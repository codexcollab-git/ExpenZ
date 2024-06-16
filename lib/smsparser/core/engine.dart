
import 'dart:ffi';

import 'package:balance_checker/smsparser/util/constants.dart';
import 'package:sms_advanced/sms_advanced.dart';

import 'account.dart';
import 'merchant.dart';
import '../model/types.dart';
import '../util/utils.dart';
import 'balance.dart';

TransactionModeEnum getTransactionMode(List<String> messageKeyList) {
  TransactionModeEnum? mode;

  if (['UPI', 'upi'].any((key) => messageKeyList.contains(key))) {
    mode = TransactionModeEnum.upi;
  }

  //deep search 'upi'
  for (int i = 0; i < messageKeyList.length; i++) {
    String key = messageKeyList[i];
    if (key.contains(RegExp(r'upi', caseSensitive: false))) {
      mode = TransactionModeEnum.upi;
    }
  }
  if (mode != null) {
    return mode;
  } else {
    if (['SIP', 'sip'].any((key) => messageKeyList.contains(key))) {
      mode = TransactionModeEnum.sip;
    }
    //deep search 'sip'
    for (int i = 0; i < messageKeyList.length; i++) {
      String key = messageKeyList[i];
      if (key.contains(RegExp(r'sip', caseSensitive: false))) {
        mode = TransactionModeEnum.sip;
      }
    }

    if (mode != null) {
      return mode;
    } else {
      if (['NEFT', 'neft'].any((key) => messageKeyList.contains(key))) {
        mode = TransactionModeEnum.neft;
      }

      //deep search 'neft'
      for (int i = 0; i < messageKeyList.length; i++) {
        String key = messageKeyList[i];
        if (key.contains(RegExp(r'neft', caseSensitive: false))) {
          mode = TransactionModeEnum.neft;
        }
      }
    }
    if (mode != null) {return mode;}
  }
  return TransactionModeEnum.other;
}

String? getTransactionAmount(List<String> messageKeyList) {
  String money = '';
  int index = messageKeyList.indexOf('rs.');

  //"rs." does not exist
  if (index == -1) return null;
  int rsPos = getNextIndex(index, 1);
  if(checkIfIndexIsNotOutOfBound(messageKeyList, rsPos)) {
    money = messageKeyList[rsPos];
    money = money.replaceAll(',', '');
    if (num.tryParse(money) != null) return padCurrencyValue(money);
  }

  // If data is false positive
  // Look ahead one index and check for valid money
  // Else return the found money
  if (num.tryParse(money) == null) {
    //next index
    int rsPos = getNextIndex(index, 2);
    if(checkIfIndexIsNotOutOfBound(messageKeyList, rsPos)) {
      money = messageKeyList[rsPos];
      money = money.replaceAll(',', '');
      if (num.tryParse(money) != null) return padCurrencyValue(money);
    }
  }
  return null;
}

TransactionType? getTransactionType(List<String> messageKeyList) {
  TransactionType type = TransactionType(typeEnum: null, keyword: null);
  RegExp creditPattern =
  RegExp(r'(?:credit|credited|deposited|added|received|refund|transferred|repayment)', caseSensitive: false);

  RegExp debitPattern =
  RegExp(r'(?:debited|debit|deducted|sent|transfer)', caseSensitive: false);

  RegExp otherPattern =
  RegExp(r'(?:payment|spent|paid|used\sat|charged|transaction\son|transaction\sfee|tran|booked|purchased|sent\sto|spent\son|puchase\sof|withdrawn)', caseSensitive: false);

  String messageStr = messageKeyList.join(" ");
  Map matches = {};

  var creditPatternMatch = creditPattern.allMatches(messageStr);
  if (creditPatternMatch.isNotEmpty) {
    type.keyword = creditPatternMatch.first.input;
    matches['credit'] = creditPatternMatch.first.start;
  }
  var debitPatternMatch = debitPattern.allMatches(messageStr);
  if (debitPatternMatch.isNotEmpty) {
    type.keyword = debitPatternMatch.first.input;
    matches['debit'] = debitPatternMatch.first.start;
  }
  var miscPatternMatch = otherPattern.allMatches(messageStr);
  if (matches.isEmpty && miscPatternMatch.isNotEmpty) {
    type.keyword = miscPatternMatch.first.input;
    matches['debit'] = miscPatternMatch.first.start;
  }

  String? minIndexMatch = null;
  int minIndex = 9999999;
  matches.forEach((key, value) {
    if (value < minIndex) {
      minIndex = value;
      minIndexMatch = key;
    }
  });
  type.typeEnum = minIndexMatch;
  return type;
}

TransactionInfo? getTransactionInfo(SmsMessage smsMessage) {
  String message = smsMessage.body!;
  List<String> messageKeyList = getProcessedMessage(message);

  //No need to calculate, return null
  if (messageKeyList.any((element) => blackListedKeywords.contains(removeSpecialCharacters(element)))) return null;

  AccountInfo account = getAccInfo(messageKeyList);
  String? availableBalance = getBalance(messageKeyList: messageKeyList, keyWordType: BalanceKeyWordsType.AVAILABLE);
  String? transactionAmt = getTransactionAmount(messageKeyList);
  double? transactionAmount = 0.0;
  if(transactionAmt != null && double.tryParse(transactionAmt) != null) {
    transactionAmount = double.tryParse(transactionAmt);
  }
  TransactionModeEnum transactionMode = getTransactionMode(messageKeyList);

  TransactionType? transType = getTransactionType(messageKeyList);
  Balance balance = Balance(available: availableBalance, outstanding: null);

  if (account.type == AccountType.CARD) {
    balance.outstanding = getBalance(messageKeyList: messageKeyList, keyWordType: BalanceKeyWordsType.OUTSTANDING);
  }

  MerchantDetails merchantDetails = extractMerchantInfo(messageKeyList, transactionMode);
  MessageInfo messageInfo = MessageInfo(id: smsMessage.id,
      sender: smsMessage.sender,
      body: smsMessage.body);

  Transaction transaction = Transaction(merchant: merchantDetails,
      amount: transactionAmount,
      message: messageInfo);

  //print('Transaction Message -> $messageKeyList');
  //print('Account -> ${account.toString()}');
  //print('Transaction info -> $availableBalance // $transactionAmount');

  if(((transactionAmount != null && transactionAmount != 0.0) && transType?.typeEnum != null) && (account.type != null || account.name != null || availableBalance != null)){
    //print('Is Transaction SMS -> true');

    return TransactionInfo(account: account,
        transactionDetail: transaction,
        transactionType: transType,
        balance: balance,
        transactionModeEnum: transactionMode,
        dateTime: smsMessage.dateSent
    );
  } else {
    //print('Is Transaction SMS -> false');
    return null;
  }
}