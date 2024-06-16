
import 'dart:async';

import 'package:balance_checker/Presentation/views/smslist/model/filter.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/utils/common/DateTimeUtils.dart';
import '../../utils/config/strings/AppStrings.dart';
import '../database/AppDatabase.dart';

abstract class SmsDBRepo {
  Future<List<SmsEntity>> getAllSms(Filter? filter);
  Future<void> insertSms(SmsEntity sms);
  Future<void> hideSms(int id);
  Future<int?> getLastSmsTimeStamp();
}

class SmsDBRepoImpl implements SmsDBRepo {
  final AppDatabase _appDatabase;

  SmsDBRepoImpl(this._appDatabase);

  Future<List<SmsEntity>> _getAllSmsList(Filter? filter) async {
    bool containsCondition = true;
    String query = 'SELECT * FROM ${AppStrings.smsTable} WHERE hide = 0';

    if (filter?.type != null && filter?.type != 'All') {
      if (containsCondition) {
        query += ' AND';
      } else {
        query += ' WHERE';
        containsCondition = true;
      }
      query += ' transactionModeEnum = \'${filter?.type?.toLowerCase()}\'';
      containsCondition = true;
    }

    if (filter?.from != null && filter?.from != 'All') {
      if (containsCondition) {
        query += ' AND';
      } else {
        query += ' WHERE';
        containsCondition = true;
      }
      query += ' accountTypeEnum = \'${filter?.from?.toUpperCase()}\'';
    }

    if(filter?.selectedDates != null) {
      DateTime? startDate = null;
      DateTime? endDate = null;

      if (filter?.selectedDates?.length == 2) {
        startDate = filter?.selectedDates?[0];
        endDate = filter?.selectedDates?[1];
      } else {
        startDate = filter?.selectedDates?[0];
      }

      if (startDate != null && endDate != null) {
        int startTimeStamp = startDate.millisecondsSinceEpoch;
        int endTimeStamp = endDate.millisecondsSinceEpoch;
        if (containsCondition) {
          query += ' AND';
        } else {
          query += ' WHERE';
          containsCondition = true;
        }
        query += ' ( smsDateTime >= $startTimeStamp AND smsDateTime <= $endTimeStamp ) ';
      } else if (startDate != null) {
        int startTimeStamp = startDate.millisecondsSinceEpoch;
        if (containsCondition) {
          query += ' AND';
        } else {
          query += ' WHERE';
          containsCondition = true;
        }
        query += ' ( smsDateTime = $startTimeStamp )';
      }
    }

    query += ';';
    print(query);
    final List<Map<String, dynamic>> result = await _appDatabase.database.rawQuery(query);

    print(result.length);
    if (result.isNotEmpty) {
      return result.map((map) => SmsEntity.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<SmsEntity>> getAllSms(Filter? filter) async {
    return _getAllSmsList(filter);
  }

  @override
  Future<void> insertSms(SmsEntity sms) async {
    return _appDatabase.smsDao.insertSms(sms);
  }

  @override
  Future<void> hideSms(int id) async {
    return _appDatabase.smsDao.hideSms(id);
  }

  @override
  Future<int?> getLastSmsTimeStamp() async {
    return _appDatabase.smsDao.getLastSmsTimeStamp();
  }
}
