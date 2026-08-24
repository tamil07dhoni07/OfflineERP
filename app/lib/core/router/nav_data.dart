class NavItem {
  const NavItem(this.key, this.label, {this.badge});
  final String key;
  final String label;
  final String? badge;
}

class NavGroup {
  const NavGroup(this.label, this.items);
  final String label;
  final List<NavItem> items;
}

/// Mirrors the prototype's `NAV` constant — same groups, order and badges.
const navGroups = <NavGroup>[
  NavGroup('OVERVIEW', [NavItem('dashboard', 'Dashboard')]),
  NavGroup('SALES', [
    NavItem('invoices', 'Sales Invoices', badge: '3'),
    NavItem('quotations', 'Quotations'),
    NavItem('receipts', 'Customer Receipts'),
  ]),
  NavGroup('PURCHASING', [
    NavItem('po', 'Purchase Orders', badge: '2'),
    NavItem('grn', 'Goods Receipt'),
    NavItem('suppay', 'Supplier Payments'),
  ]),
  NavGroup('INVENTORY', [
    NavItem('stock', 'Stock on Hand', badge: '7'),
    NavItem('transfers', 'Stock Transfers'),
    NavItem('adjust', 'Adjustments'),
  ]),
  NavGroup('MASTER DATA', [
    NavItem('customers', 'Customers'),
    NavItem('suppliers', 'Suppliers'),
    NavItem('products', 'Products'),
  ]),
  NavGroup('FINANCE', [
    NavItem('coa', 'Chart of Accounts'),
    NavItem('ledger', 'General Ledger'),
    NavItem('tb', 'Trial Balance'),
  ]),
  NavGroup('TAX · GST', [NavItem('gst', 'GST Summary'), NavItem('gstr1', 'GSTR-1 Filing')]),
  NavGroup('PEOPLE', [NavItem('employees', 'Employees'), NavItem('payroll', 'Payroll Runs')]),
  NavGroup('SYSTEM', [
    NavItem('reports', 'Reports'),
    NavItem('company', 'Company Setup'),
    NavItem('license', 'License & Devices'),
    NavItem('audit', 'Audit Log'),
  ]),
];

const crumbFor = <String, String>{
  'dashboard': 'HOME',
  'invoices': 'SALES', 'quotations': 'SALES', 'receipts': 'SALES', 'invoice-new': 'SALES / INVOICES',
  'po': 'PURCHASING', 'grn': 'PURCHASING', 'suppay': 'PURCHASING',
  'stock': 'INVENTORY', 'transfers': 'INVENTORY', 'adjust': 'INVENTORY',
  'customers': 'MASTER DATA', 'suppliers': 'MASTER DATA', 'products': 'MASTER DATA',
  'coa': 'FINANCE', 'ledger': 'FINANCE', 'tb': 'FINANCE',
  'gst': 'TAX', 'gstr1': 'TAX',
  'employees': 'PEOPLE', 'payroll': 'PEOPLE',
  'reports': 'SYSTEM', 'company': 'SYSTEM', 'license': 'SYSTEM', 'audit': 'SYSTEM',
};

const titleFor = <String, String>{
  'dashboard': 'Dashboard',
  'invoices': 'Sales Invoices', 'quotations': 'Quotations', 'receipts': 'Customer Receipts',
  'invoice-new': 'New Sales Invoice',
  'po': 'Purchase Orders', 'grn': 'Goods Receipt', 'suppay': 'Supplier Payments',
  'stock': 'Stock on Hand', 'transfers': 'Stock Transfers', 'adjust': 'Stock Adjustments',
  'customers': 'Customers', 'suppliers': 'Suppliers', 'products': 'Products',
  'coa': 'Chart of Accounts', 'ledger': 'General Ledger', 'tb': 'Trial Balance',
  'gst': 'GST Summary', 'gstr1': 'GSTR-1 Filing',
  'employees': 'Employees', 'payroll': 'Payroll Runs',
  'reports': 'Reports', 'company': 'Company Setup', 'license': 'License & Devices', 'audit': 'Audit Log',
};
