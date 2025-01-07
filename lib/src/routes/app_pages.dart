import 'package:akwe/src/ui/pages/account/account_page_view.dart';
import 'package:akwe/src/ui/pages/account/account_page_view_binding.dart';
import 'package:akwe/src/ui/pages/category/category_page_view.dart';
import 'package:akwe/src/ui/pages/category/category_page_view_binding.dart';
import 'package:akwe/src/ui/pages/home/home.dart';
import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page_view.dart';
import 'package:akwe/src/ui/pages/qr_code_found/qr_code_found_page_view_binding.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page_view.dart';
import 'package:akwe/src/ui/pages/scanner/scanner_page_view_binding.dart';
import 'package:get/get.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard.dart';
import 'package:akwe/src/ui/pages/dashboard/dashboard_binding.dart';

part 'app_routes.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: AppRoutes.HOME,
        page: () => const DashBoard(),
        binding: DashBoardBinding(),
        // transition: Transition.fadeIn,
        // middlewares: [
        //   AuthenticationGard(),
        // ]
    ),
    // GetPage(
    //   name: Routes.WELCOME,
    //   page: () => const WelcomeScreen(),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: Routes.SIGNUP,
    //   page: () => const SignUpPage(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: Routes.REGISTERWITHEMAIL,
    //   page: () => const RegisterWithEmailPage(),
    // ),
    // // verify email; send email verification.
    // GetPage(
    //   name: Routes.SIGNIN,
    //   page: () => const SignInPage(),
    //   transition: Transition.leftToRight,
    // ),
    // GetPage(
    //   name: Routes.LOGINWITHEMAIL,
    //   page: () => const LoginWithEmailPage(),
    //   binding: LoginBinding(),
    // ),
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
      page: () => CategoryPageView(),
      binding: CategoryPageViewBinding(),
    ),
    GetPage(
      name: AppRoutes.USERACCOUNT,
      page: () => AccountPageView(),
      binding: AccountPageViewBinding(),
    ),
    // GetPage(
    //   name: Routes.USERFUNDS,
    //   page: () => const FundPage(),
    //   binding: FundBinding(),
    // ),
    // GetPage(
    //   name: Routes.USERMETRICS,
    //   page: () => const MetricPage(),
    //   binding: MetricBinding(),
    // ),
    // GetPage(
    //   name: Routes.USERPERFORMANCE,
    //   page: () => const PerformancePage(),
    //   binding: PerformanceBinding(),
    // ),
    // GetPage(
    //   name: Routes.INVOICEVIEW,
    //   page: () => const InvoiceWebView(),
    //   binding: InvoiceWebBinding(),
    // ),
    //
    // GetPage(
    //   name: Routes.USERACCOUNTDETAIL,
    //   page: () => const AccountDetailPage(),
    //   binding: AccountDetailBinding(),
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.NEWUSERACCOUNT,
    //   page: () => const NewAccountPage(),
    //   binding: NewAccountBinding(),
    //   //fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.TRANSACTIONDETAIL,
    //   page: () => const TransactionDetailPage(),
    //   binding: TransactionDetailBinding(),
    // ),
    // GetPage(
    //   name: Routes.EDITTRANSACTION,
    //   page: () => const EditTransactionPage(),
    //   binding: EditTransactionBinding(),
    // ),
    //
    // GetPage(
    //   name: Routes.ROUTINEDETAIL,
    //   page: () => const PlanningDetailPage(),
    //   binding: PlanningDetailBinding(),
    // ),
    //
    // GetPage(
    //   name: Routes.NEWROUTINE,
    //   page: () => const NewPlanningPage(),
    //   binding: NewPlanningBinding(),
    // ),
    //
    // GetPage(
    //   name: Routes.EDITROUTINE,
    //   page: () => const EditPlanningPage(),
    //   binding: EditPlanningBinding(),
    // ),
    // GetPage(
    //   name: Routes.ROUTINEALL,
    //   page: () => const PlanningAllPage(),
    //   binding: PlanningAllBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.ROUTINEFILTER,
    //   page: () => const PlanningFilterPage(),
    //   binding: PlanningFilterBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.NEWBUDGET,
    //   page: () => const NewBudgetPage(),
    //   binding: NewBudgetBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.BUDGETHISTORY,
    //   page: () => const BudgetDetailPage(),
    //   binding: BudgetDetailBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.BUDGETLIST,
    //   page: () => const BudgetListPage(),
    //   binding: BudgetListBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.BUDGETFULL,
    //   page: () => const BudgetFullPage(),
    //   binding: BudgetFullBinding(),
    //   transition: Transition.rightToLeft,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.BUDGETALL,
    //   page: () => const BudgetAllPage(),
    //   binding: BudgetAllBinding(),
    //   transition: Transition.rightToLeft,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.NEWTRANSACTION,
    //   page: () => const NewTransactionPage(),
    //   binding: NewTransactionBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.TRANSACTIONFILTER,
    //   page: () => const TransactionFilterPage(),
    //   binding: TransactionFilterBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.TRANSACTIONALL,
    //   page: () => const TransactionAllPage(),
    //   binding: TransactionAllBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    //
    GetPage(
        name: AppRoutes.SCANQRCODE,
        page: () => ScannerPageView(),
        binding: ScannerPageViewBinding(),
        transition: Transition.downToUp,
        fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.QRCODEFOUND,
      page: () => const QrCodeFoundPageView(),
      binding: QrCodeFoundPageViewBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),
    //
    // GetPage(
    //   name: Routes.NEWCATEGORY,
    //   page: () => const NewCategoryPage(),
    //   binding: NewCategoryBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    //
    // GetPage(
    //   name: Routes.EDITCATEGORY,
    //   page: () => const EditCategoryPage(),
    //   binding: EditCategoryBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
    // GetPage(
    //   name: Routes.EDITACCOUNT,
    //   page: () => const EditAccountPage(),
    //   binding: EditAccountBinding(),
    //   transition: Transition.downToUp,
    //   fullscreenDialog: true,
    // ),
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
    // GetPage(
    //   name: Routes.NEWUSERGOAL,
    //   page: () => const NewGoalPage(),
    //   binding: NewGoalBinding(),
    //   transition: Transition.downToUp,
    // ),
    // GetPage(
    //   name: Routes.ADDDEPOSITTOGOAL,
    //   page: () => const GoalDepositPage(),
    //   binding: GoalDepositBinding(),
    //   transition: Transition.downToUp,
    // ),
    // GetPage(
    //   name: Routes.USERGOALDETAIL,
    //   page: () => const GoalDetailPage(),
    //   binding: GoalDetailBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: Routes.EDITUSERGOAL,
    //   page: () => const EditGoalPage(),
    //   binding: EditGoalBinding(),
    //   transition: Transition.fadeIn,
    // ),
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
    // GetPage(
    //   name: Routes.NEWTRANSFER,
    //   page: () => const NewTransferPage(),
    //   binding: NewTransferBinding(),
    //   transition: Transition.downToUp,
    // ),
    //
    // GetPage(
    //   name: Routes.EDITTRANSFER,
    //   page: () => const EditTransferPage(),
    //   binding: EditTransferBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: Routes.TRANSFERDETAIL,
    //   page: () => const TransferDetailPage(),
    //   binding: TransferDetailBinding(),
    //   transition: Transition.rightToLeft,
    // ),

  ];
}
