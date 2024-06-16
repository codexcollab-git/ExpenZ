
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:floor/floor.dart';

@dao
abstract class SmsDao {

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertSms(SmsEntity sms);

  @Query('UPDATE ${AppStrings.smsTable} SET hide = 1 where smsId= :id')
  Future<void> hideSms(int id);

  @Query('SELECT max(smsDateTime) from ${AppStrings.smsTable}')
  Future<int?> getLastSmsTimeStamp();
}