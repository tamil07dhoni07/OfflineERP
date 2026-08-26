import 'package:drift/drift.dart';

import '../utils/ids.dart';

/// Shared audit columns every operational table carries, per the ERP spec:
/// id, created/updated stamps, soft-delete marker.
mixin _AuditColumns on Table {
  TextColumn get id => text().clientDefault(newId)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

class Companies extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get legalName => text()();
  TextColumn get gstin => text()();
  TextColumn get pan => text()();
  TextColumn get state => text()();
  TextColumn get stateCode => text()();
  TextColumn get baseCurrency => text().withDefault(const Constant('INR'))();
}

@DataClassName('Branch')
class Branches extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get companyId => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
}

class Warehouses extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get branchId => text()();
  TextColumn get name => text()();
  TextColumn get notes => text().nullable()();
}

class AppUsers extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get username => text().unique()();
  TextColumn get displayName => text()();
  TextColumn get initials => text()();
  TextColumn get passwordHash => text()();
  TextColumn get pinHash => text().nullable()();
  TextColumn get role => text()();
}

class Customers extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get groupName => text()();
  TextColumn get gstin => text().nullable()();
  TextColumn get state => text()();
  TextColumn get stateCode => text()();
  IntColumn get creditLimitPaise => integer().withDefault(const Constant(0))();
}

class Suppliers extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get gstin => text().nullable()();
  TextColumn get terms => text()();
}

class Products extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get sku => text().unique()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get uom => text()();
  TextColumn get hsn => text()();
  IntColumn get purchasePricePaise => integer()();
  IntColumn get sellingPricePaise => integer()();
  RealColumn get gstRate => real()();
  IntColumn get reorderLevel => integer().withDefault(const Constant(0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

/// Every quantity change to inventory. On-hand is derived by summing this
/// ledger rather than mutated in place, matching the spec's stock-movement
/// architecture (batch/expiry simply carry null when not tracked).
class StockMovements extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get productId => text()();
  TextColumn get warehouseId => text()();
  TextColumn get kind => text()(); // in | out | adjust | transfer_in | transfer_out
  IntColumn get qtyDelta => integer()();
  IntColumn get unitCostPaise => integer()();
  TextColumn get batch => text().nullable()();
  TextColumn get refType => text()(); // grn | invoice | adjustment | transfer
  TextColumn get refId => text()();
  TextColumn get reason => text().nullable()();
  TextColumn get approvedBy => text().nullable()();
}

class Accounts extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get code => text().unique()();
  TextColumn get name => text()();
  TextColumn get groupName => text()();
  TextColumn get type => text()(); // asset | liability | equity | income | expense
  TextColumn get nature => text()(); // debit | credit
}

/// One posted transaction. Every JournalLine under an entry must balance —
/// enforced in the repository layer inside the same Drift transaction that
/// writes the entry, never left to the UI.
class JournalEntries extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get voucherNo => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get narration => text()();
  TextColumn get sourceType => text()(); // sales_invoice | payment | receipt | manual
  TextColumn get sourceId => text()();
}

class JournalLines extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get entryId => text()();
  TextColumn get accountId => text()();
  IntColumn get debitPaise => integer().withDefault(const Constant(0))();
  IntColumn get creditPaise => integer().withDefault(const Constant(0))();
  TextColumn get particulars => text()();
}

class SalesInvoices extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get invoiceNo => text().unique()();
  DateTimeColumn get date => dateTime()();
  TextColumn get customerId => text()();
  TextColumn get warehouseId => text()();
  TextColumn get placeOfSupplyState => text()();
  TextColumn get placeOfSupplyCode => text()();
  TextColumn get paymentTerms => text()();
  TextColumn get salesperson => text()();
  IntColumn get taxableValuePaise => integer()();
  IntColumn get cgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get sgstPaise => integer().withDefault(const Constant(0))();
  IntColumn get igstPaise => integer().withDefault(const Constant(0))();
  IntColumn get totalPaise => integer()();
  IntColumn get balancePaise => integer()();
  TextColumn get status => text()(); // draft | posted | part_paid | paid | overdue
}

class SalesInvoiceItems extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get invoiceId => text()();
  TextColumn get productId => text()();
  IntColumn get lineNo => integer()();
  IntColumn get qty => integer()();
  IntColumn get ratePaise => integer()();
  RealColumn get discountPct => real().withDefault(const Constant(0))();
  RealColumn get gstPct => real()();
  IntColumn get amountPaise => integer()();
}

/// A customer collection — the Collections module. One receipt can be
/// allocated across several open invoices (see [ReceiptAllocations]),
/// either auto-adjusted (oldest invoice first) or picked manually.
class Receipts extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get voucherNo => text().unique()();
  DateTimeColumn get date => dateTime()();
  TextColumn get customerId => text()();
  TextColumn get method => text()(); // cash | cheque | dd
  TextColumn get reference => text().nullable()(); // cheque / DD number
  IntColumn get amountPaise => integer()();
  IntColumn get unallocatedPaise => integer().withDefault(const Constant(0))();
}

class ReceiptAllocations extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get receiptId => text()();
  TextColumn get invoiceId => text()();
  IntColumn get amountPaise => integer()();
}

class AuditLogs extends Table with _AuditColumns {
  @override
  Set<Column> get primaryKey => {id};

  DateTimeColumn get timestamp => dateTime()();
  TextColumn get username => text()();
  TextColumn get module => text()();
  TextColumn get action => text()();
  TextColumn get recordRef => text()();
  TextColumn get oldValue => text()();
  TextColumn get newValue => text()();
  TextColumn get device => text()();
}

/// Small flexible key/value store for singleton state that doesn't warrant
/// its own table: license info, device registration, last-backup time,
/// sync status. Kept generic on purpose — this is control-plane-ish data,
/// not operational ERP data.
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
