import '../app_database.dart';
import 'accounting_repository.dart';
import 'stock_repository.dart';

class DashboardData {
  const DashboardData({
    required this.salesThisMonthPaise,
    required this.salesLastMonthPaise,
    required this.receivablesOutstandingPaise,
    required this.overdueAmountPaise,
    required this.overdueCount,
    required this.stockValuePaise,
    required this.belowReorderCount,
    required this.gstOutputCgstPaise,
    required this.gstOutputSgstPaise,
    required this.gstOutputIgstPaise,
    required this.salesByDay,
    required this.trialBalanceInAgreement,
    required this.reorderAlerts,
    required this.schemaVersion,
  });

  final int salesThisMonthPaise;
  final int salesLastMonthPaise;
  final int receivablesOutstandingPaise;
  final int overdueAmountPaise;
  final int overdueCount;
  final int stockValuePaise;
  final int belowReorderCount;
  final int gstOutputCgstPaise;
  final int gstOutputSgstPaise;
  final int gstOutputIgstPaise;
  final Map<DateTime, int> salesByDay;
  final bool trialBalanceInAgreement;
  final List<({String name, int onHand, int reorderLevel})> reorderAlerts;
  final int schemaVersion;

  double get salesDeltaPct =>
      salesLastMonthPaise == 0 ? 0 : ((salesThisMonthPaise - salesLastMonthPaise) / salesLastMonthPaise) * 100;

  int get gstNetPayablePaise => gstOutputCgstPaise + gstOutputSgstPaise + gstOutputIgstPaise;
}

class DashboardRepository {
  DashboardRepository(this._db, this._accounting, this._stock);
  final AppDatabase _db;
  final AccountingRepository _accounting;
  final StockRepository _stock;

  Future<DashboardData> load() async {
    final now = DateTime.now();
    final invoices = await (_db.select(_db.salesInvoices)..where((t) => t.status.isNotValue('draft'))).get();

    var thisMonth = 0;
    var lastMonth = 0;
    var overdueAmount = 0;
    var overdueCount = 0;
    final salesByDay = <DateTime, int>{};
    final fourteenDaysAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 13));

    for (final inv in invoices) {
      if (inv.date.year == now.year && inv.date.month == now.month) {
        thisMonth += inv.totalPaise;
      }
      final prevMonth = DateTime(now.year, now.month - 1);
      if (inv.date.year == prevMonth.year && inv.date.month == prevMonth.month) {
        lastMonth += inv.totalPaise;
      }
      if (inv.status == 'overdue') {
        overdueAmount += inv.balancePaise;
        overdueCount++;
      }
      final day = DateTime(inv.date.year, inv.date.month, inv.date.day);
      if (!day.isBefore(fourteenDaysAgo)) {
        salesByDay[day] = (salesByDay[day] ?? 0) + inv.totalPaise;
      }
    }

    final receivablesOutstanding = invoices.fold<int>(0, (a, i) => a + i.balancePaise);

    final products = await _db.select(_db.products).get();
    final levels = await _stock.onHandByProductWarehouse();
    final onHandByProduct = <String, int>{};
    final valueByProduct = <String, int>{};
    for (final l in levels) {
      onHandByProduct[l.productId] = (onHandByProduct[l.productId] ?? 0) + l.onHand;
      valueByProduct[l.productId] = (valueByProduct[l.productId] ?? 0) + l.onHand * l.avgCostPaise;
    }
    final stockValue = valueByProduct.values.fold<int>(0, (a, v) => a + v);
    final belowReorder = <({String name, int onHand, int reorderLevel})>[];
    for (final p in products) {
      final onHand = onHandByProduct[p.id] ?? 0;
      if (onHand < p.reorderLevel) {
        belowReorder.add((name: p.name, onHand: onHand, reorderLevel: p.reorderLevel));
      }
    }
    belowReorder.sort((a, b) => (a.onHand - a.reorderLevel).compareTo(b.onHand - b.reorderLevel));

    final trialBalance = await _accounting.trialBalance();
    final totalDebit = trialBalance.fold<int>(0, (a, b) => a + b.debitPaise);
    final totalCredit = trialBalance.fold<int>(0, (a, b) => a + b.creditPaise);

    int accountBalanceCredit(String code) {
      final row = trialBalance.where((b) => b.account.code == code).firstOrNull;
      if (row == null) return 0;
      return row.creditPaise - row.debitPaise;
    }

    return DashboardData(
      salesThisMonthPaise: thisMonth,
      salesLastMonthPaise: lastMonth,
      receivablesOutstandingPaise: receivablesOutstanding,
      overdueAmountPaise: overdueAmount,
      overdueCount: overdueCount,
      stockValuePaise: stockValue,
      belowReorderCount: belowReorder.length,
      gstOutputCgstPaise: accountBalanceCredit('2210'),
      gstOutputSgstPaise: accountBalanceCredit('2211'),
      gstOutputIgstPaise: accountBalanceCredit('2212'),
      salesByDay: salesByDay,
      trialBalanceInAgreement: totalDebit == totalCredit,
      reorderAlerts: belowReorder.take(4).toList(),
      schemaVersion: _db.schemaVersion,
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
