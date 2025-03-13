import 'package:akwe/src/ui/pages/account/account_page.dart';
import 'package:akwe/src/ui/pages/account/account_page_binding.dart';
import 'package:akwe/src/ui/pages/account_detail/account_detail_page.dart';
import 'package:akwe/src/ui/pages/account_detail/account_detail_page_binding.dart';
import 'package:akwe/src/ui/pages/account_edit/edit_account_page.dart';
import 'package:akwe/src/ui/pages/account_edit/edit_account_page_binding.dart';
import 'package:akwe/src/ui/pages/account_new/new_account_page.dart';
import 'package:akwe/src/ui/pages/account_new/new_account_page_binding.dart';
import 'package:akwe/src/ui/pages/budget/budget_page.dart';
import 'package:akwe/src/ui/pages/budget/budget_page_binding.dart';
import 'package:akwe/src/ui/pages/budget_all/budget_all_page.dart';
import 'package:akwe/src/ui/pages/budget_all/budget_all_page_binding.dart';
import 'package:akwe/src/ui/pages/budget_full/budget_full_page.dart';
import 'package:akwe/src/ui/pages/budget_full/budget_full_page_binding.dart';
import 'package:akwe/src/ui/pages/budget_list/budget_list_page.dart';
import 'package:akwe/src/ui/pages/budget_list/budget_list_page_binding.dart';
import 'package:akwe/src/ui/pages/budget_new/new_budget_page.dart';
import 'package:akwe/src/ui/pages/budget_new/new_budget_page_binding.dart';
import 'package:akwe/src/ui/pages/category/category_page.dart';
import 'package:akwe/src/ui/pages/category/category_page_binding.dart';
import 'package:akwe/src/ui/pages/category_edit/edit_category_page.dart';
import 'package:akwe/src/ui/pages/category_edit/edit_category_page_binding.dart';
import 'package:akwe/src/ui/pages/category_new/new_category_page.dart';
import 'package:akwe/src/ui/pages/category_new/new_category_page_binding.dart';
import 'package:akwe/src/ui/pages/fund/fund_binding.dart';
import 'package:akwe/src/ui/pages/fund/fund_page.dart';
import 'package:akwe/src/ui/pages/goal_deposit/goal_deposit_page.dart';
import 'package:akwe/src/ui/pages/goal_deposit/goal_deposit_page_binding.dart';
import 'package:akwe/src/ui/pages/goal_detail/goal_detail_page.dart';
import 'package:akwe/src/ui/pages/goal_detail/goal_detail_page_binding.dart';
import 'package:akwe/src/ui/pages/goal_edit/edit_goal_page.dart';
import 'package:akwe/src/ui/pages/goal_edit/edit_goal_page_binding.dart';
import 'package:akwe/src/ui/pages/goal_new/new_goal_page.dart';
import 'package:akwe/src/ui/pages/goal_new/new_goal_page_binding.dart';
import 'package:akwe/src/ui/pages/home/home.dart';
import 'package:akwe/src/ui/pages/invoice/invoice_web_binding.dart';
import 'package:akwe/src/ui/pages/invoice/invoice_web_view.dart';
import 'package:akwe/src/ui/pages/login/login_page.dart';
import 'package:akwe/src/ui/pages/login/login_page_binding.dart';
import 'package:akwe/src/ui/pages/planning_all/planning_all_page.dart';
import 'package:akwe/src/ui/pages/planning_all/planning_all_page_binding.dart';
import 'package:akwe/src/ui/pages/planning_detail/planning_detail_page.dart';
import 'package:akwe/src/ui/pages/planning_detail/planning_detail_page_binding.dart';
import 'package:akwe/src/ui/pages/planning_edit/edit_planning_page.dart';
import 'package:akwe/src/ui/pages/planning_edit/edit_planning_page_binding.dart';
import 'package:akwe/src/ui/pages/planning_filter/planning_filter_page.dart';
import 'package:akwe/src/ui/pages/planning_filter/planning_filter_page_binding.dart';
import 'package:akwe/src/ui/pages/planning_new/new_planning_page.dart';
import 'package:akwe/src/ui/pages/planning_new/new_planning_page_binding.dart';
import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page.dart';
import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page_binding.dart';
import 'package:akwe/src/ui/pages/register/register_page.dart';
import 'package:akwe/src/ui/pages/report/report_page.dart';
import 'package:akwe/src/ui/pages/report/report_page_binding.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page_binding.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page.dart';
import 'package:akwe/src/ui/pages/transaction_all/transaction_all_page_binding.dart';
import 'package:akwe/src/ui/pages/transaction_detail/transaction_detail_page.dart';
import 'package:akwe/src/ui/pages/transaction_detail/transaction_detail_page_binding.dart';
import 'package:akwe/src/ui/pages/transaction_edit/edit_transaction_page.dart';
import 'package:akwe/src/ui/pages/transaction_edit/edit_transaction_page_binding.dart';
import 'package:akwe/src/ui/pages/transaction_filter/transaction_filter_page.dart';
import 'package:akwe/src/ui/pages/transaction_filter/transaction_filter_page_binding.dart';
import 'package:akwe/src/ui/pages/transaction_new/new_transaction_page.dart';
import 'package:akwe/src/ui/pages/transaction_new/new_transaction_page_binding.dart';
import 'package:akwe/src/ui/pages/transfer/transfer_page.dart';
import 'package:akwe/src/ui/pages/transfer/transfer_page_binding.dart';
import 'package:akwe/src/ui/pages/transfer_detail/transfer_detail_page.dart';
import 'package:akwe/src/ui/pages/transfer_detail/transfer_detail_page_binding.dart';
import 'package:akwe/src/ui/pages/transfer_edit/transfer_edit_page.dart';
import 'package:akwe/src/ui/pages/transfer_edit/transfer_edit_page_binding.dart';
import 'package:akwe/src/ui/pages/transfer_new/new_transfer_page.dart';
import 'package:akwe/src/ui/pages/transfer_new/new_transfer_page_binding.dart';
import 'package:get/get.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard_binding.dart';

import '../middlewares/auth_guard.dart';
import '../ui/pages/register/register_page_binding.dart';

part 'app_routes.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const DashBoard(),
      binding: DashBoardBinding(),
      transition: Transition.fadeIn,
      middlewares: [
        AuthenticationGuard(),
      ]
    ),
    // GetPage(
    //   name: Routes.WELCOME,
    //   page: () => const WelcomeScreen(),
    //   transition: Transition.noTransition,
    // ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginPageBinding()
    ),
    GetPage(
        name: AppRoutes.REGISTER,
        page: () => RegisterPage(),
        binding: RegisterPageBinding(),
      transition: Transition.leftToRight,
      fullscreenDialog: true,
    ),
    // GetPage(
    //   name: Routes.USERPROFILE,
    //   page: () => const UserProfilePage(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //     name: Routes.USERPREMIUM,
    //     page: () => const PremiumPage(),
    //     binding: PremiumBinding()),
    GetPage(
      name: AppRoutes.USERCATEGORY,
      page: () => CategoryPage(),
      binding: CategoryPageBinding(),
    ),
    GetPage(
      name: AppRoutes.USERACCOUNT,
      page: () => AccountPage(),
      binding: AccountPageBinding(),
    ),
    GetPage(
      name: AppRoutes.USERFUNDS,
      page: () => FundPage(),
      binding: FundBinding(),
    ),
    GetPage(
      name: AppRoutes.USERMETRICS,
      page: () => ReportPage(),
      binding: ReportPageBinding(),
    ),
    // GetPage(
    //   name: Routes.USERPERFORMANCE,
    //   page: () => const PerformancePage(),
    //   binding: PerformanceBinding(),
    // ),
    GetPage(
      name: AppRoutes.INVOICEVIEW,
      page: () => InvoiceWebView(),
      binding: InvoiceWebBinding(),
    ),

    GetPage(
      name: AppRoutes.USERACCOUNTDETAIL,
      page: () => AccountDetailPage(),
      binding: AccountDetailPageBinding(),
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.NEWUSERACCOUNT,
      page: () => NewAccountPage(),
      binding: NewAccountPageBinding(),
      //fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.TRANSACTIONDETAIL,
      page: () => TransactionDetailPage(),
      binding: TransactionDetailPageBinding(),
    ),
    GetPage(
      name: AppRoutes.EDITTRANSACTION,
      page: () => EditTransactionPage(),
      binding: EditTransactionPageBinding(),
    ),
    GetPage(
      name: AppRoutes.TRANSACTIONFILTER,
      page: () => TransactionFilterPage(),
      binding: TransactionFilterPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.TRANSACTIONALL,
      page: () => TransactionAllPage(),
      binding: TransactionAllPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.ROUTINEDETAIL,
      page: () => PlanningDetailPage(),
      binding: PlanningDetailPageBinding(),
    ),

    GetPage(
      name: AppRoutes.NEWROUTINE,
      page: () => NewPlanningPage(),
      binding: NewPlanningPageBinding(),
    ),

    GetPage(
      name: AppRoutes.EDITROUTINE,
      page: () => EditPlanningPage(),
      binding: EditPlanningPageBinding(),
    ),
    GetPage(
      name: AppRoutes.ROUTINEALL,
      page: () => PlanningAllPage(),
      binding: PlanningAllPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.ROUTINEFILTER,
      page: () => PlanningFilterPage(),
      binding: PlanningFilterPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.NEWBUDGET,
      page: () => NewBudgetPage(),
      binding: NewBudgetPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.BUDGET,
      page: () => BudgetPage(),
      binding: BudgetPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.BUDGETLIST,
      page: () => BudgetListPage(),
      binding: BudgetListPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.BUDGETFULL,
      page: () => BudgetFullPage(),
      binding: BudgetFullPageBinding(),
      transition: Transition.rightToLeft,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.BUDGETALL,
      page: () => BudgetAllPage(),
      binding: BudgetAllPageBinding(),
      transition: Transition.rightToLeft,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.NEWTRANSACTION,
      page: () => NewTransactionPage(),
      binding: NewTransactionPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.SCANQRCODE,
      page: () => ScannerPage(),
      binding: ScannerPageViewBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.QRCODEFOUND,
      page: () => QrCodeFoundPage(),
      binding: QrCodeFoundPageViewBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.NEWCATEGORY,
      page: () => NewCategoryPage(),
      binding: NewCategoryPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    GetPage(
      name: AppRoutes.EDITCATEGORY,
      page: () => EditCategoryPage(),
      binding: EditCategoryPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.EDITACCOUNT,
      page: () => EditAccountPage(),
      binding: EditAccountPageBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    // GetPage(
    //   name: Routes.MOREOPTIONS,
    //   page: () => const MoreOptionPage(),
    //   //binding: EditAccountBinding(),
    //   transition: Transition.rightToLeft,
    //   fullscreenDialog: false,
    // ),
    // GetPage(
    //   name: Routes.SETTINGS,
    //   page: () => const SettingPage(),
    //   //binding: EditAccountBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: false,
    // ),
    // GetPage(
    //   name: Routes.PREFERENCES,
    //   page: () => const PreferencePage(),
    //   //binding: EditAccountBinding(),
    //   transition: Transition.fadeIn,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.ALERTNOTIFICATION,
    //   page: () => const AlertNotificationSetting(),
    //   //binding: EditAccountBinding(),
    //   transition: Transition.fadeIn,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.SECURITYSETTING,
    //   page: () => const SecuritySetting(),
    //   binding: SecurityBinding(),
    //   transition: Transition.fadeIn,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.ADVANCEDSETTING,
    //   page: () => const AdvancedSetting(),
    //   //binding: EditAccountBinding(),
    //   transition: Transition.fadeIn,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.USERGOAL,
    //   page: () => const GoalPage(),
    //   binding: GoalBinding(),
    //   transition: Transition.fadeIn,
    // ),
    GetPage(
      name: AppRoutes.NEWUSERGOAL,
      page: () => NewGoalPage(),
      binding: NewGoalPageBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.ADDDEPOSITTOGOAL,
      page: () => GoalDepositPage(),
      binding: GoalDepositPageBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.USERGOALDETAIL,
      page: () => GoalDetailPage(),
      binding: GoalDetailPageBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.EDITUSERGOAL,
      page: () => EditGoalPage(),
      binding: EditGoalPageBinding(),
      transition: Transition.fadeIn,
    ),
    // GetPage(
    //   name: Routes.LOCALAUTH,
    //   page: () => const LocalAuthPage(),
    //   binding: LocalAuthBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: Routes.USERDATA,
    //   page: () => const UserDataPage(),
    //   binding: UserDataBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    //
    GetPage(
      name: AppRoutes.NEWTRANSFER,
      page: () => NewTransferPage(),
      binding: NewTransferPageBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.TRANSFERS,
      page: () => TransferPage(),
      binding: TransferPageBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.EDITTRANSFER,
      page: () => EditTransferPage(),
      binding: EditTransferPageBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRANSFERDETAIL,
      page: () => TransferDetailPage(),
      binding: TransferDetailPageBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
