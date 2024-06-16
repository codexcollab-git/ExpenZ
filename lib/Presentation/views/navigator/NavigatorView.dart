
import 'dart:io';

import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/SmsListWidget.dart';
import 'package:balance_checker/Presentation/views/smspermission/SmsPermissionView.dart';
import 'package:balance_checker/utils/common/DateTimeUtils.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../floor/helper/SmsDBRepo.dart';
import '../../../locator.dart';
import '../../../utils/common/CommonUtils.dart';
import '../../../utils/config/colors/AppColors.dart';
import '../../../utils/prefs/SharedPref.dart';
import '../../cubit/localsms/SmsListResult.dart';
import '../common/TextWidget.dart';
import '../smslist/SmsListView.dart';

class NavigatorView extends StatefulWidget {
  @override
  _Navigator createState() => _Navigator();
}

class _Navigator extends State<NavigatorView> {

  @override
  void initState() {
    super.initState();
    _navigateFurther();
  }

  _navigateFurther() async {
    var pref = GetIt.instance<SharedPref>();
    await Future.delayed(Duration(seconds: 3), () {});
    _checkIfPermissionAvailable().then((onValue) {
      if (onValue) {
        _checkFurther(context, pref);
      } else {
        replaceNextPage(context, SmsPermissionView());
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                  child: Container(
                      width: 220,
                      height: 180,
                      child: Image.asset('assets/images/appicon.png'))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.productOf, style: TextStyle(fontSize: 12, fontFamily: 'RedditSans', fontWeight: FontWeight.w600, color: AppColors.primaryTextColor),),
                      SpaceWidget(width: 5,),
                      Image.asset('assets/images/codexcollablogo.png', height: 15, width: 120,),
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }

  Future _checkIfPermissionAvailable() async {
    if (Platform.isAndroid){
      if (await Permission.sms.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  _checkFurther(BuildContext context, SharedPref pref) {
    if (pref.firstSyncComplete) {
      int currentTimestamp = getLastNHourTimestamp(dueHour: 3);
      if (currentTimestamp > pref.lastSyncTime) {
        replaceNextPage(context, SmsPermissionView());
      } else {
        replaceNextPage(context, SmsListView());
      }
    } else {
      replaceNextPage(context, SmsPermissionView());
    }
  }
}