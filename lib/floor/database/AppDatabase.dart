
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:balance_checker/floor/dao/SmsDao.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';

/** To generate g.dart file
 * Run 'flutter pub run build_runner build --delete-conflicting-outputs'
 * in terminal */
part 'AppDatabase.g.dart';

//@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [SmsEntity])
abstract class AppDatabase extends FloorDatabase {
  SmsDao get smsDao;
}
