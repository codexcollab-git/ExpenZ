
import '../model/types.dart';
import '../util/utils.dart';
import '../util/constants.dart';

String? getBalance({required List<String> messageKeyList, BalanceKeyWordsType keyWordType = BalanceKeyWordsType.AVAILABLE}) {

  String messageString = messageKeyList.join(" ");
  int indexOfKeyWord = -1;
  String? balance = '';
  List balanceKeyWords = keyWordType ==
      BalanceKeyWordsType.AVAILABLE ? availableBalanceKeywords
      : outstandingBalanceKeywords;

  for (String word in balanceKeyWords) {
    indexOfKeyWord = messageString.indexOf(word);
    if (indexOfKeyWord != -1) {
      indexOfKeyWord += word.length;
      break;
    } else {
      continue;
    }
  }
  if (indexOfKeyWord == -1) {
    return null;
  }
  int index = indexOfKeyWord;
  int indexOfRs = -1;
  String nextThreeChars = messageString.substring(index, index + 3);

  index += 3;

  while (index < messageString.length) {
    nextThreeChars = nextThreeChars.substring(1);
    nextThreeChars += messageString[index];

    if (nextThreeChars == 'rs.') {
      indexOfRs = index + 2;
      break;
    }

    index += 1;
  }

  if (indexOfRs == -1) {
    balance = findNonStandardBalance(message: messageString);
    return balance != null ? padCurrencyValue(balance) : null;
  }

  balance = extractBalance(indexOfRs, messageString, messageString.length);

  return balance != null ? padCurrencyValue(balance) : null;
}

String? findNonStandardBalance({required String message,
      BalanceKeyWordsType keyWordType = BalanceKeyWordsType.AVAILABLE}) {

  List balanceKeywords = keyWordType == BalanceKeyWordsType.AVAILABLE
      ? availableBalanceKeywords
      : outstandingBalanceKeywords;

  String balKeywordRegex = balanceKeywords.join('|').replaceAll('/', '\\/');

  // balance 100.00
  RegExp regex =
  RegExp('$balKeywordRegex\\s*[\\d]+\\.*[\\d]*', caseSensitive: false);
  List<RegExpMatch> matches = regex.allMatches(message).toList();
  if (matches.isNotEmpty) {
    var balance = matches.first[0]!.split(" ").last; // return only first match
    return num.tryParse(balance) == null ? '' : balance;
  }

  // 100.00 available
  regex = RegExp('[\\d]+\\.*[\\d]*\\s*$balKeywordRegex', caseSensitive: false);
  matches = regex.allMatches(message).toList();
  if (matches.isNotEmpty) {
    var balance = matches.first[0]!.split(" ").first; // return only first match
    return num.tryParse(balance) == null ? '' : balance;
  }

  return null;
}

String? extractBalance(int index, String message, int length) {
  String balance = '';
  bool sawNumber = false;
  int invalidCharCount = 0;
  String char = '';
  int start = index;
  while (start < length) {
    char = message[start];

    if (num.tryParse(char) != null) {
      sawNumber = true;
      // is_start = false;
      balance += char;
    } else if (sawNumber) {
      if (char == '.') {
        if (invalidCharCount == 1) {
          break;
        } else {
          balance += char;
          invalidCharCount += 1;
        }
      } else if (char != ',') {
        break;
      }
    }
    start += 1;
  }
  return balance;
}