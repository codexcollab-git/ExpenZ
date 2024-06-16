
import 'dart:ffi';

import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
enum AccountType { CARD, WALLET, ACCOUNT }

@jsonSerializable
enum BalanceKeyWordsType { AVAILABLE, OUTSTANDING }

@jsonSerializable
class AccountInfo {

  @JsonProperty(converter: enumConverterNumeric)
  AccountType? type;
  String? number;
  String? name;

  AccountInfo({required this.type, required this.number, required this.name});

  @override
  String toString() {
    return '{number: $number, name: $name, type: ${type.toString()}}';
  }
}

@jsonSerializable
class Balance {
  String? available;
  String? outstanding;

  Balance({required this.available, required this.outstanding});

  @override
  String toString() {
    return '{available: $available, outstanding: $outstanding}';
  }
}

typedef TMessageType = StringOrListOfStrings;

@jsonSerializable
class StringOrListOfStrings {
  List<String>? list;
  String? string;

  StringOrListOfStrings({this.list, this.string});

  @override
  String toString() {
    return '{list: ${list.toString()}, string: $string }';
  }
}

@jsonSerializable
class MessageInfo {
  int? id;
  String? sender;
  String? body;

  MessageInfo({this.id, this.sender, this.body});

  @override
  String toString() {
    return '{id: $id, sender: $sender, body: $body}';
  }
}

@jsonSerializable
enum TransactionModeEnum { neft, sip, upi, other }

@jsonSerializable
class Transaction {
  MessageInfo? message;
  double? amount;
  MerchantDetails? merchant;

  Transaction({this.message, this.amount, this.merchant});

  @override
  String toString() {
    return '{message: ${message.toString()}, amount: ${amount.toString()}, merchant: ${merchant.toString()} }';
  }
}

@jsonSerializable
class MerchantDetails {
  String? merchant;
  String? referenceNo;
  String? bankName;

  MerchantDetails({this.merchant, this.referenceNo, this.bankName});

  @override
  String toString() {
    return '{merchant: $merchant, referenceNo: $referenceNo, bankName: $bankName}';
  }
}

@jsonSerializable
class TransactionType {
  String? typeEnum;
  String? keyword;

  TransactionType({this.typeEnum, this.keyword});

  @override
  String toString() {
    return '{typeEnum: $typeEnum, keyword: $keyword}';
  }
}

@jsonSerializable
class TransactionInfo {
  Transaction? transactionDetail;
  AccountInfo account;
  TransactionType? transactionType;
  TransactionModeEnum transactionModeEnum;
  Balance balance;
  DateTime? dateTime;

  TransactionInfo(
      {required this.transactionDetail,
        required this.account,
        required this.transactionType,
        required this.balance,
        required this.transactionModeEnum,
        required this.dateTime,
      });

  @override
  String toString() {
    return '{transactionDetail: ${transactionDetail.toString()}, account: ${account.toString()}, transactionType: $transactionType, balance: ${balance.toString()}, transactionMode: ${transactionModeEnum.toString()}, dateTime: ${dateTime.toString()} }';
  }
}

@jsonSerializable
class CombinedWords {
  RegExp? regExp;
  String? word;

  @JsonProperty(converter: enumConverterNumeric)
  AccountType? type;
  String? name;

  CombinedWords({required this.regExp, required this.word, required this.type, required this.name});

  @override
  String toString() {
    return '{regExp: ${regExp.toString()}, word: $word, type: ${type.toString()} }';
  }
}

@jsonSerializable
class UPIAddresses {
  RegExp? regExp;
  String? name;
  String? address;

  UPIAddresses({required this.regExp, required this.name, required this.address});

  @override
  String toString() {
    return '{regExp: ${regExp.toString()}, name: $name, address: $address}';
  }
}