import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/utils/common/DateTimeUtils.dart';

import '../model/types.dart';

mapSmsToSmsEntity({required Transaction? transaction, required AccountInfo? account,
  required TransactionType? transactionType, required Balance? balance,
  required TransactionModeEnum? transactionModeEnum, required DateTime? dateTime}) {

  SmsEntity entity = SmsEntity();
  entity.smsId = transaction?.message?.id;
  entity.smsSender = transaction?.message?.sender;
  entity.smsBody = transaction?.message?.body;
  entity.amountOutstanding = balance?.outstanding;

  entity.smsDateTime = onlyDateTimestamp(now: dateTime);

  entity.transactionAmount = transaction?.amount;

  entity.merchant = transaction?.merchant?.merchant;
  entity.referenceNo = transaction?.merchant?.referenceNo;
  entity.bankName = transaction?.merchant?.bankName;

  entity.accountTypeEnum = account?.type?.name;
  entity.accountName = account?.name;
  entity.accountNo = account?.number;

  entity.transactionTypeEnum = transactionType?.typeEnum;
  entity.transactionKeyword = transactionType?.keyword;

  entity.transactionModeEnum = transactionModeEnum?.name;

  entity.amountAvailable = balance?.available;
  return entity;
}