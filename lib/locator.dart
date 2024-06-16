

import 'package:balance_checker/floor/helper/SmsDBRepo.dart';
import 'package:balance_checker/utils/prefs/SharedPref.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/config/strings/AppStrings.dart';
import 'floor/database/AppDatabase.dart';


final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(AppStrings.databaseName).build();

  /** Single ref instance AppDatabase */
  locator.registerSingleton<AppDatabase>(db);

  /** Single ref instance SmsDBRepo */
  locator.registerSingleton<SmsDBRepo>(
    SmsDBRepoImpl(locator<AppDatabase>()),
  );

  locator.registerSingleton<SharedPreferences>(
     await SharedPreferences.getInstance(),
  );

  /** Single ref instance SharedPref */
  locator.registerSingleton<SharedPref>(
    SharedPref(),
  );
}
