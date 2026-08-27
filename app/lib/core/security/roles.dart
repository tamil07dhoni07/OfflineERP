/// The app's role model. `superAdmin` is architecturally separate from
/// everything else — it's the control-plane operator, never a tenant's
/// ERP user, and per the spec must never see a client's private ERP
/// transactions. Every other role is a normal ERP user scoped to nav-level
/// module access (which sidebar items they can even reach), not
/// field/action-level permissions within a screen — that finer grain isn't
/// implemented yet.
enum AppRole {
  superAdmin,
  admin,
  accountant,
  sales,
  store,
  hr,
  auditor;

  static AppRole fromDb(String value) => AppRole.values.firstWhere((r) => r.name == value, orElse: () => AppRole.admin);

  String get label => switch (this) {
    AppRole.superAdmin => 'Super Admin',
    AppRole.admin => 'Admin',
    AppRole.accountant => 'Accountant',
    AppRole.sales => 'Sales',
    AppRole.store => 'Store',
    AppRole.hr => 'HR',
    AppRole.auditor => 'Auditor',
  };
}

/// Which sidebar nav item keys (see nav_data.dart) each ERP role can reach.
/// `admin` gets everything; every other role is an explicit allow-list —
/// a new module added to the nav later is invisible to non-admin roles
/// until someone deliberately adds it here, which is the safer default for
/// access control than an opt-out list.
const Map<AppRole, Set<String>> roleNavAccess = {
  AppRole.admin: {
    'dashboard', 'invoices', 'invoice-new', 'quotations', 'receipts',
    'po', 'grn', 'suppay',
    'stock', 'transfers', 'adjust',
    'customers', 'suppliers', 'products',
    'coa', 'ledger', 'tb',
    'gst', 'gstr1',
    'employees', 'attendance', 'leave', 'payroll',
    'reports', 'company', 'license', 'audit',
  },
  AppRole.accountant: {
    'dashboard', 'invoices', 'invoice-new', 'quotations', 'receipts',
    'po', 'grn', 'suppay',
    'customers', 'suppliers',
    'coa', 'ledger', 'tb', 'gst', 'gstr1',
    'reports',
  },
  AppRole.sales: {
    'dashboard', 'invoices', 'invoice-new', 'quotations', 'receipts',
    'customers', 'products', 'reports',
  },
  AppRole.store: {
    'dashboard', 'stock', 'transfers', 'adjust', 'grn', 'po',
    'products', 'suppliers', 'reports',
  },
  AppRole.hr: {
    'dashboard', 'employees', 'attendance', 'leave', 'payroll', 'reports',
  },
  AppRole.auditor: {
    'dashboard', 'audit', 'coa', 'ledger', 'tb', 'reports',
  },
};

bool navKeyAllowedFor(AppRole role, String key) => roleNavAccess[role]?.contains(key) ?? false;
