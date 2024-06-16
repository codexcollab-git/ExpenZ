
class AppStrings {
  // App
  static const String productOf = 'A Product Of';
  static const String appTitle = 'BalanceChecker';

  // Storage and Databases
  static const String smsTable = 'smsTable';
  static const String databaseName = 'app_database.db';

  //Dialog
  static const String allow = 'Allow';
  static const String cancel = 'Cancel';
  static const String refresh = "Refresh";
  static const String goBack = "Go Back";
  static const String openSetting = 'Open Settings';

  //Permission
  static const String smsPermissionDeniedHead = 'Requires SMS Permission';
  static const String smsPermissionDeniedBody = 'Our app needs SMS permission to securely read transaction alerts and conveniently display them for your budgeting needs, Please allow us sms permission.';
  static const String smsPermissionPermanentDeniedBody = 'Our app needs SMS permission to securely read transaction alerts and conveniently display them for your budgeting needs, Please enable it in setting.';

  //Transaction Type
  static const String upi = 'UPI';
  static const String sip = 'SIP';
  static const String other = 'Other';
  static const String neft = 'NEFT';
  static const String loading = 'Loading...';
  static const String sitBackRelax = 'Just sit back & relax';

  static const String inProgressScreenHead = 'Preparing Your Passbook';
  static const String calculateExpense = 'Calculating your Expenses..';
  static const String inProgressScreenSubHead = 'This might take a few moments. Please stay on this screen until the process is complete.';

  static const String firstTimeNoSmsPermissionHead = 'SMS Permission Needed';
  static const String firstTimeNoSmsPermissionSubHead = 'To display your transaction history, we need permission to read your SMS messages. Allow us SMS permission by pressing below button.';
  static const String firstTimeButtonHead = 'Allow SMS Access';

  static const String noTransactionsHead = 'No Transactions Available';
  static const String noTransactionsSubHead = "We couldn't find any transaction related messages on your device. Please ensure your messages are properly received or try again later.";

  static const String noFilterHead = 'Oops! You Look Lost..';
  static const String noFilterSubHead = "We couldn't find any transaction based on your selections, try updating your filter's.";

  static const String remove = 'Delete';
  static const String removeTransaction = 'Delete Transaction?';
  static const String removeTransactionSubHead = "Are you sure you want to delete this transaction, Once deleted, it can't be undone!";

  static const String deletedSuccessfully = 'Transaction deleted successfully.';

  static const String last7days = 'Last 7 Days';
  static const String lastMonth = 'Last 31 Days';
  static const String last3Month = 'Last 3 Months';
  static const String last6Month = 'Last 6 Months';
  static const String last12Month = 'Last 12 Months';
  static const String AllMonths = 'All Months';

  //Filters
  static const String filter = "Filter";
  static const String apply = 'Apply';
  static const String transactionMode = 'Transaction Mode';
  static const String transactionType = 'Transaction Type';

  static const List<Map<String, String>> quotes = [
    {"title": "A penny saved is a penny earned.", "by": "Benjamin Franklin"},
    {"title": "Save money and money will save you.", "by": "Jamaican Proverb"},
    {"title": "Do not save what is left after spending, but spend what is left after saving.", "by": "Warren Buffett"},
    {"title": "The art is not in making money, but in keeping it.", "by": "Proverb"},
    {"title": "Beware of little expenses; a small leak will sink a great ship.", "by": "Benjamin Franklin"},
    {"title": "The quickest way to double your money is to fold it in half and put it in your back pocket.", "by": "Will Rogers"},
    {"title": "If you would be wealthy, think of saving as well as getting.", "by": "Benjamin Franklin"},
    {"title": "A budget is telling your money where to go instead of wondering where it went.", "by": "Dave Ramsey"},
    {"title": "It’s not your salary that makes you rich, it’s your spending habits.", "by": "Charles A. Jaffe"},
    {"title": "Money looks better in the bank than on your feet.", "by": "Sophia Amoruso"},
    {"title": "Don’t save what is left after spending; spend what is left after saving.", "by": "Warren Buffett"},
    {"title": "Savings, remember, is the prerequisite of investment.", "by": "Campbell McConnell"},
    {"title": "Cut your coat according to your cloth.", "by": "English Proverb"},
    {"title": "The best way to save money is not to lose it.", "by": "Les Williams"},
    {"title": "Saving is a fine thing. Especially when your parents have done it for you.", "by": "Winston Churchill"},
    {"title": "Save a little money each month and at the end of the year, you’ll be surprised at how little you have.", "by": "Ernest Haskins"},
    {"title": "A simple fact that is hard to learn is that the time to save money is when you have some.", "by": "Joe Moore"},
    {"title": "Saving money is the best thing. Especially when your parents have done it for you.", "by": "Anonymous"},
    {"title": "If saving money is wrong, I don’t want to be right!", "by": "William Shatner"},
    {"title": "The more you save, the more you earn.", "by": "Warren Buffett"},
    {"title": "Save money on the big, boring stuff so that you have something left over for life’s little pleasures.", "by": "Elisabeth Leamy"},
    {"title": "Financial freedom is available to those who learn about it and work for it.", "by": "Robert Kiyosaki"},
    {"title": "A penny saved is two pence clear.", "by": "Benjamin Franklin"},
    {"title": "Save your money. You’re going to need twice as much money in your old age as you think.", "by": "Michael Caine"},
    {"title": "The habit of saving is itself an education; it fosters every virtue, teaches self-denial, cultivates the sense of order, trains to forethought, and so broadens the mind.", "by": "T.T. Munger"}
  ];
}
