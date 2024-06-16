
import 'dart:convert';

import 'constants.dart';

List<String> cleanMessages(List<String> messages) {
  List<String> newMessages = [];
  RegExp transactionMessagePattern =
  RegExp(r'(?=.*credit|.*debit)(?=.*a/c)', caseSensitive: false);
  messages.forEach((message) {
    if(message.isNotEmpty){
      Iterable<Match> matches = transactionMessagePattern.allMatches(message);
      if (matches.isNotEmpty) {
        newMessages.add(message);
      }
    }
  });
  return newMessages;
}

String trimLeadingAndTrailingChars(String str) {
  if (RegExp(r'[0-9]').allMatches(str).isEmpty) {
    return "";
  }
  String first = str[0];
  String last = str[str.length - 1];
  String finalStr =
  (num.tryParse(last) != null) ? str : str.substring(0, str.length - 1);
  finalStr =
  (num.tryParse(first) != null) ? finalStr : finalStr.substring(0, 1);
  return finalStr;
}

String extractBondedAccountNo(String accountNo) {
  String strippedAccountNo = accountNo.replaceAll(r'ac', "");
  return num.tryParse(strippedAccountNo) != null ? strippedAccountNo : "";
}

List<String> processMessage(String message) {
  String messageStr = message.toLowerCase();
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'!'), "");
  messageStr = messageStr.replaceAll(RegExp(r':'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\/'), "");
  messageStr = messageStr.replaceAll(RegExp(r'='), " ");
  messageStr = messageStr.replaceAll(RegExp(r'[{}]'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\n'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'\r'), " ");
  messageStr = messageStr.replaceAll(RegExp(r'ending '), "");
  messageStr = messageStr.replaceAll(RegExp(r'x|[*]'), "");
  messageStr = messageStr.replaceAll(RegExp(r'is '), "");
  messageStr = messageStr.replaceAll(RegExp(r'with '), "");
  messageStr = messageStr.replaceAll(RegExp(r'no. '), "");
  messageStr = messageStr.replaceAll(RegExp(r'\bac\b|\bacct\b|\baccount\b'), "ac");
  messageStr = messageStr.replaceAll(RegExp(r'rs(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'rs '), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'inr(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'inr '), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'rs. '), "rs.");
  messageStr = messageStr.replaceAll(RegExp(r'rs.(?=\w)'), "rs. ");
  messageStr = messageStr.replaceAll(RegExp(r'debited'), " debited ");
  messageStr = messageStr.replaceAll(RegExp(r'credited'), " credited ");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  messageStr = messageStr.replaceAll(RegExp(r'-'), "");
  combinedWordsList.forEach((word) {
    messageStr = messageStr.replaceAll(word.regExp!, word.word!);
  });
  return messageStr.split(" ").where((e) => e != "").toList();
}

List<String> getProcessedMessage(dynamic message) {
  List<String> processedMessage = [];
  if (message is String) {
    processedMessage = processMessage(message);
  } else {
    processedMessage = message;
  }
  return processedMessage;
}

padCurrencyValue(String balance) {
  if (balance.contains('.') == false) {
    balance = balance + '.00';
  }
  List<String?> temp = balance.split('.');
  return '${temp[0]}.${(temp[1] ?? '').padRight(2, '0')}';
}

String getNextWords(String source, String searchWord, {int count = 1}) {
  final splits = source.split(searchWord);
  final nextGroup = splits.length > 1 ? splits[1] : null;
  if (nextGroup != null) {
    final wordSplitRegex = RegExp(r'[^0-9a-zA-Z]+');
    return nextGroup.trim().split(wordSplitRegex).take(count).join(" ");
  }
  return "";
}

int getNextIndex(int initialIndex, int count) {
  return initialIndex + count;
}

bool checkIfIndexIsNotOutOfBound(List<String> messageKeyList, int nextIndex) {
  if (nextIndex < messageKeyList.length) {
     return true;
  } else {
     return false;
  }
}

String removeSpecialCharacters(String str) {
  RegExp specialCharPattern = RegExp(r'[^\w\s]');
  return str.replaceAll(specialCharPattern, '');
}

String getPrettyJSONString(jsonObject){
  var encoder = JsonEncoder.withIndent("     ");
  return encoder.convert(jsonObject);
}