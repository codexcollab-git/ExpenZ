
import '../util/constants.dart';
import '../model/types.dart';
import '../util/utils.dart';

AccountInfo getAccInfo(List<String> messageKeyList) {
  AccountInfo account = AccountInfo(type: AccountType.ACCOUNT, number: null, name: null);
  int indexAc = messageKeyList.indexOf('ac');
  if (indexAc != -1) {
    int nextIndex = getNextIndex(indexAc, 1);
    if(checkIfIndexIsNotOutOfBound(messageKeyList, nextIndex)) {
      var accountNo = trimLeadingAndTrailingChars(messageKeyList[nextIndex]);
      if (num.tryParse(accountNo) != null) {
        account.type = AccountType.ACCOUNT;
        account.number = trimAccountNo(accountNo);
        return account;
      }
    }
  }

  //deep search 'ac'
  for (int i = 0; i < messageKeyList.length; i++) {
    String key = messageKeyList[i];
    if (key.contains(RegExp(r'ac', caseSensitive: false))) {
      String extractedAccountNo = extractBondedAccountNo(key);
      if (extractedAccountNo != "" && num.tryParse(extractedAccountNo) != null) {
        account.type = AccountType.ACCOUNT;
        account.number = trimAccountNo(extractedAccountNo);
        return account;
      }
    }
  }

  //check for wallet keyword now!
  if (account.type == null) {
    String wallet = messageKeyList.firstWhere((word) => wallets.contains(word), orElse: () => "",);
    if (wallet != "") {
      account.type = AccountType.WALLET;
      account.name = wallet;
      return account;
    }
  }

  //check for card keyword now!
  for (int i = 0; i < messageKeyList.length; i++) {
    String key = messageKeyList[i];
    CombinedWords? word = combinedWordsList.where((element) => element.word == key).firstOrNull;
    if (word != null) {
      account.type = word.type!;
      account.name = word.name!;

      int nextIndex = getNextIndex(i, 1);
      if (checkIfIndexIsNotOutOfBound(messageKeyList, nextIndex)) {
        String cardNo = messageKeyList[nextIndex];
        if(num.tryParse(cardNo) != null) {
          account.number = trimAccountNo(cardNo);
        }
      }
      return account;
    }
  }
  return account;
}

String? trimAccountNo(String accNo) {
  //Not valid account no.
  if (RegExp(r'[0-9]').allMatches(accNo).isEmpty) {
    return null;
  }

  //account exceeding length
  if (accNo.length > 4) {
    String acNo = accNo.substring(accNo.length - 4);
    return acNo;
  } else {
    return accNo;
  }
}