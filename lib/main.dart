
import 'package:balance_checker/Presentation/views/smspermission/SmsPermissionView.dart';
import 'package:balance_checker/Presentation/views/syncsms/SyncSmsView.dart';
import 'package:balance_checker/utils/config/colors/AppColors.dart';
import 'package:balance_checker/utils/config/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

import 'Presentation/views/navigator/NavigatorView.dart';
import 'Presentation/views/smslist/SmsListView.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeMode _themeMode = ThemeMode.light;//ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.indicatorColor
    ));
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData.light(),
        /*darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),*/
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: Container(
          child: OKToast(
            child: NavigatorView(),
          ),
        ),
      ),
    );
  }
}