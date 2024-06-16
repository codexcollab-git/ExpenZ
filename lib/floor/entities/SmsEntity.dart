
import 'dart:ffi';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../utils/config/strings/AppStrings.dart';


@jsonSerializable
@Entity(tableName: AppStrings.smsTable)
class SmsEntity extends Equatable {
  @PrimaryKey(autoGenerate: false)
  int? smsId;
  String? smsSender;
  String? smsBody;

  double? transactionAmount;

  String? merchant;
  String? referenceNo;
  String? bankName;

  String? accountTypeEnum;
  String? accountNo;
  String? accountName;

  String? transactionTypeEnum;
  String? transactionKeyword;

  String? transactionModeEnum;

  String? amountAvailable;
  String? amountOutstanding;
  int hide;

  int? smsDateTime;

  SmsEntity({this.smsId,
    this.smsSender,
    this.smsBody,
    this.transactionAmount,
    this.merchant,
    this.referenceNo,
    this.bankName,
    this.accountTypeEnum,
    this.accountNo,
    this.accountName,
    this.transactionTypeEnum,
    this.transactionKeyword,
    this.transactionModeEnum,
    this.amountAvailable,
    this.amountOutstanding,
    this.hide = 0,
    this.smsDateTime});

  factory SmsEntity.fromMap(Map<String, dynamic> map) {
    return SmsEntity(
      smsId: map['smsId'] as int?,
      smsSender: map['smsSender'] as String?,
      smsBody: map['smsBody'] as String?,
      transactionAmount: map['transactionAmount'] as double?,
      merchant: map['merchant'] as String?,
      referenceNo: map['referenceNo'] as String?,
      bankName: map['bankName'] as String?,
      accountTypeEnum: map['accountTypeEnum'] as String?,
      accountNo: map['accountNo'] as String?,
      accountName: map['accountName'] as String?,
      transactionTypeEnum: map['transactionTypeEnum'] as String?,
      transactionKeyword: map['transactionKeyword'] as String?,
      transactionModeEnum: map['transactionModeEnum'] as String?,
      amountAvailable: map['amountAvailable'] as String?,
      amountOutstanding: map['amountOutstanding'] as String?,
      hide: map['hide'] as int,
      smsDateTime: map['smsDateTime'] as int?,
    );
  }

  @override
  String toString() {
    return '{ smsId: $smsId, smsSender: $smsSender, smsBody: $smsBody, '
        'transactionAmount: $transactionAmount, merchant: $merchant, referenceNo: $referenceNo, '
        'bankName: $bankName, accountTypeEnum: $accountTypeEnum, accountNo: $accountNo, '
        'accountName: $accountName, transactionTypeEnum: $transactionTypeEnum, '
        'transactionKeyword: $transactionKeyword, transactionModeEnum: $transactionModeEnum, '
        'amountAvailable: $amountAvailable, amountOutstanding: $amountOutstanding, hide: $hide, '
        'smsDateTime: $smsDateTime}';
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      smsId,
      smsSender,
      smsBody,
      transactionAmount,
      merchant,
      referenceNo,
      bankName,
      accountTypeEnum,
      accountNo,
      accountName,
      transactionTypeEnum,
      transactionKeyword,
      transactionModeEnum,
      amountAvailable,
      amountOutstanding,
      hide,
      smsDateTime
    ];
  }
}