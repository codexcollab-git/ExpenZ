
import 'dart:async';

import '../util/constants.dart';
import '../util/utils.dart';
import '../model/types.dart';

MerchantDetails extractMerchantInfo(List<String> messageKeyList, TransactionModeEnum modeEnum) {
  String messageString = messageKeyList.join(" ");
  MerchantDetails merchantDetails = MerchantDetails(merchant: null, referenceNo: null, bankName: null);

  if (messageKeyList.contains("vpa")) {
    int idx = messageKeyList.indexOf("vpa");
    if (idx < messageKeyList.length - 1) {
      String nextStr = messageKeyList[idx + 1];
      String name = nextStr.replaceAll(RegExp(r'\(|\)'), " ").split(" ")[0];
      merchantDetails.merchant = name;
    }
  }

  String match = "";
  for (String keyword in upiKeywords) {
    int idx = messageString.indexOf(keyword);
    if (idx > 0) {
      match = keyword;
    }
  }

  if (match.isNotEmpty) {
    String nextWord = getNextWords(messageString, match);
    if (num.tryParse(nextWord) != null){
      merchantDetails.referenceNo = nextWord;
    } else if (merchantDetails.merchant != null) {
      String longestNumeric = nextWord
          .split(RegExp(r'[^0-9]'))
          .where((element) => element.isNotEmpty)
          .toList()
          .reduce((value, element) => value.length > element.length ? value : element);
      if (longestNumeric.isNotEmpty) {
        merchantDetails.referenceNo = longestNumeric;
      }
    } else {
      merchantDetails.merchant = nextWord;
    }
  }
  if(modeEnum == TransactionModeEnum.upi){
    merchantDetails.bankName = getUPIAddress(messageKeyList);
  }
  merchantDetails.bankName ??= getBankName(messageKeyList);
  return merchantDetails;
}

String? getUPIAddress(List<String> messageKeyList) {
  for (String key in messageKeyList) {
    for (UPIAddresses upi in upiAddresses) {
      if (key.toLowerCase().contains(upi.address!.toLowerCase())) {
        return upi.name!;
      }
    }
  }
  return null;
}

String? getBankName(List<String> messageKeyList) {
  for (String key in messageKeyList) {
    if (key.toLowerCase() != 'bank') {
      for (String bank in banksList) {
        List<String> name = bank.split(" ");
        if (name.any((word) => word.toLowerCase() == key.toLowerCase())) {
          return bank;
        }
      }
    }
  }
  return null;
}