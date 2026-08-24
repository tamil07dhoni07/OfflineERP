import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';

const _uuid = Uuid();

class AccountBalance {
  const AccountBalance({required this.account, required this.debitPaise, required this.creditPaise});
  final Account account;
  final int debitPaise;
  final int creditPaise;

  /// Net balance signed per the account's natural side — positive means
  /// the account sits on its natural (debit for asset/expense, credit for
  /// liability/equity/income) side.
  int get netPaise => account.nature == 'debit' ? debitPaise - creditPaise : creditPaise - debitPaise;
}

class LedgerRow {
  const LedgerRow({
    required this.date,
    required this.voucherNo,
    required this.particulars,
    required this.debitPaise,
    required this.creditPaise,
    required this.runningBalancePaise,
  });
  final DateTime date;
  final String voucherNo;
  final String particulars;
  final int debitPaise;
  final int creditPaise;
  final int runningBalancePaise;
}

/// Wraps every journal write, and only every journal write, in a single
/// Drift transaction — the "single transaction, all-or-nothing" guarantee
/// the spec requires for financial postings.
class AccountingRepository {
  AccountingRepository(this._db);
  final AppDatabase _db;

  Future<List<Account>> allAccounts() => _db.select(_db.accounts).get();

  Stream<List<Account>> watchAccounts() =>
      (_db.select(_db.accounts)..orderBy([(t) => OrderingTerm.asc(t.code)])).watch();

  Future<List<AccountBalance>> trialBalance() async {
    final accounts = await allAccounts();
    final result = <AccountBalance>[];
    for (final account in accounts) {
      final lines = await (_db.select(_db.journalLines)..where((t) => t.accountId.equals(account.id))).get();
      var debit = 0;
      var credit = 0;
      for (final l in lines) {
        debit += l.debitPaise;
        credit += l.creditPaise;
      }
      result.add(AccountBalance(account: account, debitPaise: debit, creditPaise: credit));
    }
    return result;
  }

  Future<List<LedgerRow>> ledgerFor(String accountId) async {
    final query = _db.select(_db.journalLines).join([
      innerJoin(_db.journalEntries, _db.journalEntries.id.equalsExp(_db.journalLines.entryId)),
    ])
      ..where(_db.journalLines.accountId.equals(accountId))
      ..orderBy([OrderingTerm.asc(_db.journalEntries.date)]);
    final rows = await query.get();
    var running = 0;
    final out = <LedgerRow>[];
    for (final row in rows) {
      final line = row.readTable(_db.journalLines);
      final entry = row.readTable(_db.journalEntries);
      running += line.debitPaise - line.creditPaise;
      out.add(
        LedgerRow(
          date: entry.date,
          voucherNo: entry.voucherNo,
          particulars: entry.narration,
          debitPaise: line.debitPaise,
          creditPaise: line.creditPaise,
          runningBalancePaise: running,
        ),
      );
    }
    return out;
  }

  /// Posts a balanced journal entry inside one transaction. Throws if the
  /// supplied lines don't balance — callers must never be able to commit a
  /// partial or unbalanced financial transaction.
  Future<String> postJournal({
    required String voucherNo,
    required DateTime date,
    required String narration,
    required String sourceType,
    required String sourceId,
    required List<({String accountId, int debitPaise, int creditPaise, String particulars})> lines,
  }) async {
    final totalDebit = lines.fold<int>(0, (a, l) => a + l.debitPaise);
    final totalCredit = lines.fold<int>(0, (a, l) => a + l.creditPaise);
    if (totalDebit != totalCredit) {
      throw StateError('Journal entry does not balance: debit $totalDebit vs credit $totalCredit');
    }
    final entryId = _uuid.v4();
    await _db.transaction(() async {
      await _db
          .into(_db.journalEntries)
          .insert(
            JournalEntriesCompanion.insert(
              id: Value(entryId),
              voucherNo: voucherNo,
              date: date,
              narration: narration,
              sourceType: sourceType,
              sourceId: sourceId,
            ),
          );
      for (final line in lines) {
        await _db
            .into(_db.journalLines)
            .insert(
              JournalLinesCompanion.insert(
                entryId: entryId,
                accountId: line.accountId,
                debitPaise: Value(line.debitPaise),
                creditPaise: Value(line.creditPaise),
                particulars: line.particulars,
              ),
            );
      }
    });
    return entryId;
  }
}
