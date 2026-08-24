import 'package:drift/drift.dart';

import '../security/password_hasher.dart';
import 'app_database.dart';
import 'repositories/accounting_repository.dart';
import 'repositories/stock_repository.dart';

const seedDevPassword = 'nexus123';

/// Populates a freshly created database with the same realistic dataset the
/// approved Claude Design prototype shipped with — same customers,
/// products, invoices and figures — so the app looks identical on first
/// run. Runs once: no-ops if a company already exists.
Future<void> seedIfEmpty(AppDatabase db) async {
  final existing = await db.select(db.companies).get();
  if (existing.isNotEmpty) return;

  final accounting = AccountingRepository(db);
  final stock = StockRepository(db);

  const companyId = 'company-nexus';
  const branchId = 'branch-mumbai-hq';
  const whBhiwandi = 'wh-bhiwandi-1';
  const whMumbai2 = 'wh-mumbai-2';
  const whPune3 = 'wh-pune-3';

  await db.into(db.companies).insert(
    CompaniesCompanion.insert(
      id: const Value(companyId),
      legalName: 'Nexus Traders Private Limited',
      gstin: '27AAECN1180K1Z5',
      pan: 'AAECN1180K',
      state: 'Maharashtra',
      stateCode: '27',
    ),
  );
  await db.into(db.branches).insert(
    BranchesCompanion.insert(id: const Value(branchId), companyId: companyId, name: 'Mumbai HQ', kind: 'Head office · billing'),
  );
  for (final w in [
    (whBhiwandi, 'Bhiwandi WH-1', 'Warehouse · 42,000 sq ft'),
    (whMumbai2, 'Mumbai WH-2', 'Warehouse · packaging'),
    (whPune3, 'Pune WH-3', 'Warehouse · regional'),
  ]) {
    await db
        .into(db.warehouses)
        .insert(WarehousesCompanion.insert(id: Value(w.$1), branchId: branchId, name: w.$2, notes: Value(w.$3)));
  }

  final userSeed = [
    ('r.deshmukh', 'Rohit Deshmukh', 'RD', 'Owner'),
    ('s.iyer', 'Sneha Iyer', 'SI', 'Warehouse Supervisor'),
    ('a.patil', 'Arun Patil', 'AP', 'Sales Executive'),
    ('admin', 'System Administrator', 'AD', 'Administrator'),
  ];
  for (final u in userSeed) {
    await db.into(db.appUsers).insert(
      AppUsersCompanion.insert(
        username: u.$1,
        displayName: u.$2,
        initials: u.$3,
        passwordHash: PasswordHasher.hash(seedDevPassword),
        role: u.$4,
      ),
    );
  }

  // ---- Chart of accounts -------------------------------------------------
  const accountsSeed = [
    ('1000', 'Cash in Hand', 'Current Assets', 'asset', 'debit'),
    ('1010', 'HDFC Current A/c ···4471', 'Bank Accounts', 'asset', 'debit'),
    ('1200', 'Accounts Receivable', 'Current Assets', 'asset', 'debit'),
    ('1400', 'Inventory — Trading Goods', 'Current Assets', 'asset', 'debit'),
    ('2100', 'Accounts Payable', 'Current Liabilities', 'liability', 'credit'),
    ('2210', 'Output CGST', 'Duties & Taxes', 'liability', 'credit'),
    ('2211', 'Output SGST', 'Duties & Taxes', 'liability', 'credit'),
    ('2212', 'Output IGST', 'Duties & Taxes', 'liability', 'credit'),
    ('3000', 'Share Capital', 'Equity', 'equity', 'credit'),
    ('4000', 'Sales — Trading Goods', 'Revenue', 'income', 'credit'),
    ('5000', 'Cost of Goods Sold', 'Direct Costs', 'expense', 'debit'),
    ('6100', 'Salaries & Wages', 'Operating Expenses', 'expense', 'debit'),
  ];
  final accountIdByCode = <String, String>{};
  for (final a in accountsSeed) {
    final id = 'acct-${a.$1}';
    accountIdByCode[a.$1] = id;
    await db.into(db.accounts).insert(
      AccountsCompanion.insert(id: Value(id), code: a.$1, name: a.$2, groupName: a.$3, type: a.$4, nature: a.$5),
    );
  }

  // ---- Products -----------------------------------------------------------
  const productsSeed = [
    ('PLY-3410', 'HDPE Granules 25 kg', 'Polymers', 'BAG', '39012000', 82000, 105000, 18.0, 60),
    ('PLY-3411', 'LDPE Granules 25 kg', 'Polymers', 'BAG', '39011010', 79500, 99000, 18.0, 60),
    ('STL-1180', 'MS Angle 50×50×6', 'Steel', 'PCS', '72161000', 121400, 148000, 18.0, 150),
    ('STL-1181', 'MS Flat 40×6', 'Steel', 'PCS', '72149910', 108800, 132800, 18.0, 120),
    ('PKG-0902', 'Corrugated Box 12×9×6', 'Packaging', 'PCS', '48191010', 3500, 4600, 12.0, 1000),
    ('PKG-0903', 'Stretch Film 500 mm', 'Packaging', 'ROLL', '39232990', 16200, 20500, 18.0, 200),
    ('CHM-7741', 'Isopropyl Alcohol 20 L', 'Chemicals', 'CAN', '29051220', 330000, 385000, 18.0, 40),
  ];
  final productIdBySku = <String, String>{};
  for (final p in productsSeed) {
    final id = 'prod-${p.$1.toLowerCase()}';
    productIdBySku[p.$1] = id;
    await db.into(db.products).insert(
      ProductsCompanion.insert(
        id: Value(id),
        sku: p.$1,
        name: p.$2,
        category: p.$3,
        uom: p.$4,
        hsn: p.$5,
        purchasePricePaise: p.$6,
        sellingPricePaise: p.$7,
        gstRate: p.$8,
        reorderLevel: Value(p.$9),
      ),
    );
  }

  // Opening stock — one "opening" IN movement per (product, warehouse).
  const openingStock = [
    ('PLY-3410', whBhiwandi, 18, 82000),
    ('STL-1180', whBhiwandi, 412, 121400),
    ('PKG-0902', whMumbai2, 2500, 3500),
    ('CHM-7741', whBhiwandi, 22, 330000),
    ('PLY-3411', whMumbai2, 144, 79500),
    ('STL-1181', whBhiwandi, 96, 108800),
    ('PKG-0903', whMumbai2, 310, 16200),
  ];
  var openingInventoryValuePaise = 0;
  for (final s in openingStock) {
    openingInventoryValuePaise += s.$3 * s.$4;
    await stock.recordMovement(
      productId: productIdBySku[s.$1]!,
      warehouseId: s.$2,
      kind: 'in',
      qtyDelta: s.$3,
      unitCostPaise: s.$4,
      refType: 'opening',
      refId: 'opening-balance',
    );
  }

  // ---- Customers ------------------------------------------------------------
  const customersSeed = [
    ('C-0041', 'Kaveri Retail LLP', 'Retail', '27AACCK1234M1Z8', 'Maharashtra', '27', 50000000),
    ('C-0038', 'Suryodaya Distributors', 'Distributor', '29AAFCS8821K1ZP', 'Karnataka', '29', 150000000),
    ('C-0033', 'Meghdoot Wholesale', 'Wholesale', '27AADCM6612H1ZQ', 'Maharashtra', '27', 100000000),
    ('C-0029', 'Chandrika Enterprises', 'Retail', '27AABCC3390J1ZK', 'Maharashtra', '27', 20000000),
    ('C-0022', 'Nandan Traders', 'Distributor', '24AAECN9017P1Z2', 'Gujarat', '24', 80000000),
    ('C-0014', 'Bhagyashree Stores', 'Retail', '27AAGCB4410L1ZR', 'Maharashtra', '27', 15000000),
    ('C-0009', 'Ratnagiri Agencies', 'Wholesale', '27AAJCR5502F1ZD', 'Maharashtra', '27', 60000000),
  ];
  final customerIdByCode = <String, String>{};
  for (final c in customersSeed) {
    final id = 'cust-${c.$1.toLowerCase()}';
    customerIdByCode[c.$1] = id;
    await db.into(db.customers).insert(
      CustomersCompanion.insert(
        id: Value(id),
        code: c.$1,
        name: c.$2,
        groupName: c.$3,
        gstin: Value(c.$4),
        state: c.$5,
        stateCode: c.$6,
        creditLimitPaise: Value(c.$7),
      ),
    );
  }

  // ---- Suppliers --------------------------------------------------------
  const suppliersSeed = [
    ('S-0018', 'Sahyadri Polymers', 'Raw material', '27AAECS7712N1ZV', 'Net 45'),
    ('S-0015', 'Konkan Steel Co', 'Raw material', '27AAFCK3301B1ZH', 'Net 30'),
    ('S-0011', 'Deccan Packaging', 'Packaging', '27AAGCD9920R1ZT', 'Net 15'),
    ('S-0007', 'Godavari Chemicals', 'Consumables', '27AAJCG1180M1ZF', 'Advance'),
  ];
  for (final s in suppliersSeed) {
    await db.into(db.suppliers).insert(
      SuppliersCompanion.insert(code: s.$1, name: s.$2, category: s.$3, gstin: Value(s.$4), terms: s.$5),
    );
  }

  // ---- Opening balance journal (funds the business before any trading) --
  await accounting.postJournal(
    voucherNo: 'JV/OPEN',
    date: DateTime(2026, 4, 1),
    narration: 'Opening balances — FY 2026-27',
    sourceType: 'manual',
    sourceId: 'opening-balance',
    lines: [
      (accountId: accountIdByCode['1000']!, debitPaise: 10000000, creditPaise: 0, particulars: 'Opening cash'),
      (accountId: accountIdByCode['1010']!, debitPaise: 150000000, creditPaise: 0, particulars: 'Opening bank'),
      (
        accountId: accountIdByCode['1400']!,
        debitPaise: openingInventoryValuePaise,
        creditPaise: 0,
        particulars: 'Opening stock',
      ),
      (
        accountId: accountIdByCode['3000']!,
        debitPaise: 0,
        creditPaise: 10000000 + 150000000 + openingInventoryValuePaise,
        particulars: 'Capital introduced',
      ),
    ],
  );

  // ---- Historical sales invoices (with matching AR journal + receipts) --
  // (invoiceNo, customerCode, date, stateName, stateCode, taxableP, cgstP, sgstP, igstP, totalP, balanceP, status)
  final invoiceSeed = [
    (
      'INV/26-27/0412',
      'C-0041',
      DateTime(2026, 8, 24),
      'Maharashtra',
      '27',
      24850000,
      2236500,
      2236500,
      0,
      29323000,
      0, // drafts aren't posted yet, so they carry no real receivable balance
      'draft',
    ),
    (
      'INV/26-27/0411',
      'C-0038',
      DateTime(2026, 8, 23),
      'Karnataka',
      '29',
      61200000,
      0,
      0,
      11016000,
      72216000,
      72216000,
      'posted',
    ),
    (
      'INV/26-27/0410',
      'C-0014',
      DateTime(2026, 8, 22),
      'Maharashtra',
      '27',
      8740000,
      786600,
      786600,
      0,
      10313200,
      0,
      'paid',
    ),
    (
      'INV/26-27/0409',
      'C-0022',
      DateTime(2026, 8, 21),
      'Gujarat',
      '24',
      34190000,
      0,
      0,
      6154200,
      40344200,
      15000000,
      'part_paid',
    ),
    (
      'INV/26-27/0408',
      'C-0029',
      DateTime(2026, 8, 19),
      'Maharashtra',
      '27',
      11925000,
      1073250,
      1073250,
      0,
      14071500,
      14071500,
      'overdue',
    ),
    (
      'INV/26-27/0407',
      'C-0041',
      DateTime(2026, 8, 18),
      'Maharashtra',
      '27',
      9400000,
      846000,
      846000,
      0,
      11092000,
      0,
      'paid',
    ),
    (
      'INV/26-27/0406',
      'C-0033',
      DateTime(2026, 8, 17),
      'Maharashtra',
      '27',
      50875000,
      4578750,
      4578750,
      0,
      60032500,
      20000000,
      'part_paid',
    ),
    (
      'INV/26-27/0405',
      'C-0009',
      DateTime(2026, 8, 16),
      'Maharashtra',
      '27',
      6230000,
      560700,
      560700,
      0,
      7351400,
      0,
      'paid',
    ),
    (
      'INV/26-27/0404',
      'C-0038',
      DateTime(2026, 8, 14),
      'Karnataka',
      '29',
      27760000,
      0,
      0,
      4996800,
      32756800,
      0,
      'paid',
    ),
    (
      'INV/26-27/0403',
      'C-0014',
      DateTime(2026, 8, 13),
      'Maharashtra',
      '27',
      4185000,
      376650,
      376650,
      0,
      4938300,
      4938300,
      'overdue',
    ),
  ];

  var receiptSeq = 900;
  for (final inv in invoiceSeed) {
    final customerId = customerIdByCode[inv.$2]!;
    final total = inv.$10;
    final balance = inv.$11;
    final status = inv.$12;

    await db.into(db.salesInvoices).insert(
      SalesInvoicesCompanion.insert(
        invoiceNo: inv.$1,
        date: inv.$3,
        customerId: customerId,
        warehouseId: whBhiwandi,
        placeOfSupplyState: inv.$4,
        placeOfSupplyCode: inv.$5,
        paymentTerms: 'Net 30',
        salesperson: 'Arun Patil',
        taxableValuePaise: inv.$6,
        cgstPaise: Value(inv.$7),
        sgstPaise: Value(inv.$8),
        igstPaise: Value(inv.$9),
        totalPaise: total,
        balancePaise: balance,
        status: status,
      ),
    );

    if (status == 'draft') continue;

    await accounting.postJournal(
      voucherNo: 'JV/${inv.$1.split('/').last}',
      date: inv.$3,
      narration: '${inv.$1} — ${inv.$2}',
      sourceType: 'sales_invoice',
      sourceId: inv.$1,
      lines: [
        (accountId: accountIdByCode['1200']!, debitPaise: total, creditPaise: 0, particulars: inv.$2),
        (accountId: accountIdByCode['4000']!, debitPaise: 0, creditPaise: inv.$6, particulars: 'revenue'),
        if ((inv.$7) > 0)
          (accountId: accountIdByCode['2210']!, debitPaise: 0, creditPaise: inv.$7, particulars: 'CGST'),
        if ((inv.$8) > 0)
          (accountId: accountIdByCode['2211']!, debitPaise: 0, creditPaise: inv.$8, particulars: 'SGST'),
        if ((inv.$9) > 0)
          (accountId: accountIdByCode['2212']!, debitPaise: 0, creditPaise: inv.$9, particulars: 'IGST'),
      ],
    );

    final received = total - balance;
    if (received > 0) {
      receiptSeq++;
      await accounting.postJournal(
        voucherNo: 'RCP/0$receiptSeq',
        date: inv.$3.add(const Duration(days: 1)),
        narration: 'Receipt against ${inv.$1}',
        sourceType: 'receipt',
        sourceId: inv.$1,
        lines: [
          (accountId: accountIdByCode['1010']!, debitPaise: received, creditPaise: 0, particulars: 'bank'),
          (accountId: accountIdByCode['1200']!, debitPaise: 0, creditPaise: received, particulars: inv.$2),
        ],
      );
    }
  }

  // A small operating-expense entry so 6100 isn't perpetually zero.
  await accounting.postJournal(
    voucherNo: 'JV/PAYROLL-JUL',
    date: DateTime(2026, 7, 31),
    narration: 'Payroll — Jul 2026',
    sourceType: 'manual',
    sourceId: 'payroll-jul-2026',
    lines: [
      (accountId: accountIdByCode['6100']!, debitPaise: 204320000, creditPaise: 0, particulars: 'Jul 2026 net payable'),
      (accountId: accountIdByCode['1010']!, debitPaise: 0, creditPaise: 204320000, particulars: 'bank'),
    ],
  );

  // ---- Audit log seed (historical, matches the original mockup) ---------
  final auditSeed = [
    (
      DateTime(2026, 8, 24, 11, 42),
      'r.deshmukh',
      'Sales',
      'invoice.created',
      'INV/26-27/0412',
      '—',
      'draft',
      'WIN-MUM-04',
    ),
    (
      DateTime(2026, 8, 24, 10, 18),
      's.iyer',
      'Inventory',
      'stock.adjusted',
      'PKG-0902',
      '2,524',
      '2,500',
      'AND-WH-11',
    ),
    (
      DateTime(2026, 8, 23, 18, 5),
      'r.deshmukh',
      'Products',
      'price.changed',
      'CHM-7741',
      '3,700',
      '3,850',
      'WIN-MUM-04',
    ),
    (
      DateTime(2026, 8, 23, 16, 31),
      'admin',
      'Users',
      'permission.granted',
      'a.patil',
      'sales.read',
      'sales.write',
      'WIN-MUM-01',
    ),
    (
      DateTime(2026, 8, 22, 4, 0),
      'system',
      'Backup',
      'backup.completed',
      'bkp_20260822_0400',
      '—',
      'verified',
      'WIN-MUM-04',
    ),
    (
      DateTime(2026, 8, 21, 9, 12),
      'r.deshmukh',
      'Sales',
      'invoice.voided',
      'INV/26-27/0398',
      'posted',
      'voided',
      'WIN-MUM-04',
    ),
  ];
  for (final a in auditSeed) {
    await db.into(db.auditLogs).insert(
      AuditLogsCompanion.insert(
        timestamp: a.$1,
        username: a.$2,
        module: a.$3,
        action: a.$4,
        recordRef: a.$5,
        oldValue: a.$6,
        newValue: a.$7,
        device: a.$8,
      ),
    );
  }

  // ---- App settings (license/device/backup control-plane-ish state) -----
  const settings = {
    'license.status': 'ACTIVE',
    'license.key': 'NXS-IN-4471-9930-KLQ',
    'license.plan': 'Business · 5 devices',
    'license.activatedAt': '2026-04-12',
    'license.expiresAt': '2027-04-11',
    'license.lastRevalidation': '2026-08-03T09:14:00',
    'license.offlineGraceDays': '21',
    'device.id': 'WIN-MUM-04',
    'device.platform': 'Windows 11 · desktop',
    'backup.lastAt': '2026-08-24T04:00:00',
    'backup.sizeMb': '84.2',
  };
  for (final e in settings.entries) {
    await db.into(db.appSettings).insert(AppSettingsCompanion.insert(key: e.key, value: e.value));
  }
}
