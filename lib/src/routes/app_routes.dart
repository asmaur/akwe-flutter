part of 'app_pages.dart';

abstract class AppRoutes {
  static const  String HOME = "/";
  static const String WELCOME = "/welcome";
  static const String LOGIN = "/login";
  static const String REGISTER = "/register";
  static const String LOGINWITHEMAIL = "/login-email";
  static const String REGISTERWITHEMAIL = "/register-email";
  static const String USERDATA = "/user-data";

  // Menu
  static const String USERPROFILE = "/profile";
  static const String USERCATEGORY = "/categories";
  static const String USERACCOUNT = "/accounts";
  static const String USERACCOUNTDETAIL = "/account-detail";
  static const String NEWUSERACCOUNT = "/new-account";
  static const String USERFUNDS = "/funds";
  static const String USERMETRICS = "/metrics";
  static const String USERPREMIUM = "/premium";
  static const String USERPERFORMANCE = "/performance";

  static const String SCANQRCODE = "/scan-qr-code";
  static const String QRCODEFOUND = "/qr-code-found";


  static const String INVOICEVIEW = "/invoice-view";
  static const String INVOICEUNPROCESSED = "/invoice-unprocessed";
  static const String TRANSACTIONDETAIL = "/transaction-detail";
  static const String TRANSACTIONS = "/transactions";
  static const String NEWTRANSACTION = "/new-transaction";
  static const String TRANSACTIONFILTER = "/transaction-filter";
  static const String TRANSACTIONALL = "/transaction-all";
  static const String EDITTRANSACTION = "/transaction-edit";

  static const String ROUTINES = "/routines";
  static const String NEWROUTINE = "/new-routine";
  static const String ROUTINEDETAIL = "/routine-detail";
  static const String EDITROUTINE = "/routine-edit";
  static const String ROUTINEALL = "/routine-all";
  static const String ROUTINEFILTER = "/routine-filter";
  static const String NEWBUDGET = "/new-budget";
  static const String BUDGET = "/budget";
  static const String BUDGETLIST = "/budget-list";
  static const String BUDGETFULL = "/budget-full";
  static const String BUDGETALL = "/budget-all";
  static const String BUDGETPREVIOUS = "/budget-previous";
  static const String NEWCATEGORY = "/new-category";
  static const String EDITCATEGORY = "/edit-category";
  static const String EDITACCOUNT = "/edit-account";

  static const String USERGOAL = "/goals";
  static const String EDITUSERGOAL = "/edit-goal";
  static const String USERGOALDETAIL = "/goal-detail";
  static const String NEWUSERGOAL = "/new-goal";
  static const String ADDDEPOSITTOGOAL = "/add-deposit-goal";

  static const String MOREOPTIONS = "/more-options";
  static const String SETTINGS = "/settings";
  static const String PREFERENCES = "/preferences";

  static const String SECURITYSETTING = "/security";
  static const String ADVANCEDSETTING = "/advanced-setting";
  static const String ALERTNOTIFICATION = "/alert-notification";
  static const String LOCALAUTH = "/auth";

  static const String TRANSFERS = "/transfers";
  static const String NEWTRANSFER = "/transfer";
  static const String EDITTRANSFER = "/transfer-edit";
  static const String TRANSFERDETAIL = "/transfer-detail";

}