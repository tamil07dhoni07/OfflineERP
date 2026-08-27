import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/audit/audit_screen.dart';
import '../../features/auth/auth_controller.dart';
import '../../features/auth/login_screen.dart';
import '../../features/accounting/chart_of_accounts_screen.dart';
import '../../features/accounting/general_ledger_screen.dart';
import '../../features/accounting/trial_balance_screen.dart';
import '../../features/company/company_screen.dart';
import '../../features/customers/customers_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/hr/attendance_screen.dart';
import '../../features/hr/employees_screen.dart';
import '../../features/hr/leave_screen.dart';
import '../../features/hr/payroll_screen.dart';
import '../../features/inventory/adjustments_screen.dart';
import '../../features/inventory/stock_screen.dart';
import '../../features/inventory/transfers_screen.dart';
import '../../features/license/license_screen.dart';
import '../../features/products/products_screen.dart';
import '../../features/purchasing/goods_receipt_screen.dart';
import '../../features/purchasing/purchase_orders_screen.dart';
import '../../features/purchasing/supplier_payments_screen.dart';
import '../../features/reports/reports_screen.dart';
import '../../features/sales/invoice_new_screen.dart';
import '../../features/sales/invoices_screen.dart';
import '../../features/sales/quotations_screen.dart';
import '../../features/sales/receipts_screen.dart';
import '../../features/superadmin/clients_screen.dart';
import '../../features/suppliers/suppliers_screen.dart';
import '../../features/taxation/gst_summary_screen.dart';
import '../../features/taxation/gstr1_screen.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/super_admin_shell.dart';
import '../security/roles.dart';

class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Ref ref) {
    ref.listen(authControllerProvider, (prev, next) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthRefresh(ref);

  GoRoute page(String key, Widget Function() build) {
    return GoRoute(
      path: '/$key',
      builder: (context, state) => AppShell(activeKey: key, child: build()),
    );
  }

  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: refresh,
    redirect: (context, state) {
      final authed = ref.read(isAuthedProvider);
      final atLogin = state.matchedLocation == '/login';
      if (!authed) return atLogin ? null : '/login';

      final user = ref.read(authControllerProvider);
      final role = AppRole.fromDb(user?.role ?? 'admin');
      final path = state.matchedLocation;
      final isAdminArea = path.startsWith('/admin');

      // Super Admin is a separate control-plane persona: it only ever sees
      // /admin/*, and nobody else can reach /admin/* — enforced here, not
      // just by hiding the sidebar, since a bookmarked/typed URL has to be
      // blocked the same way a hidden nav item is.
      if (role == AppRole.superAdmin) {
        if (atLogin || !isAdminArea) return '/admin/clients';
        return null;
      }
      if (isAdminArea) return '/dashboard';
      if (atLogin) return '/dashboard';

      final key = path.replaceFirst('/', '');
      if (key.isNotEmpty && !navKeyAllowedFor(role, key == 'invoice-new' ? 'invoices' : key)) {
        return '/${roleNavAccess[role]!.first}';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/admin/clients',
        builder: (context, state) => const SuperAdminShell(child: ClientsScreen()),
      ),
      page('dashboard', () => const DashboardScreen()),
      page('invoices', () => const InvoicesScreen()),
      page('invoice-new', () => const InvoiceNewScreen()),
      page('quotations', () => const QuotationsScreen()),
      page('receipts', () => const ReceiptsScreen()),
      page('po', () => const PurchaseOrdersScreen()),
      page('grn', () => const GoodsReceiptScreen()),
      page('suppay', () => const SupplierPaymentsScreen()),
      page('stock', () => const StockScreen()),
      page('transfers', () => const TransfersScreen()),
      page('adjust', () => const AdjustmentsScreen()),
      page('customers', () => const CustomersScreen()),
      page('suppliers', () => const SuppliersScreen()),
      page('products', () => const ProductsScreen()),
      page('coa', () => const ChartOfAccountsScreen()),
      page('ledger', () => const GeneralLedgerScreen()),
      page('tb', () => const TrialBalanceScreen()),
      page('gst', () => const GstSummaryScreen()),
      page('gstr1', () => const Gstr1Screen()),
      page('employees', () => const EmployeesScreen()),
      page('attendance', () => const AttendanceScreen()),
      page('leave', () => const LeaveScreen()),
      page('payroll', () => const PayrollScreen()),
      page('reports', () => const ReportsScreen()),
      page('company', () => const CompanyScreen()),
      page('license', () => const LicenseScreen()),
      page('audit', () => const AuditScreen()),
    ],
  );
});
