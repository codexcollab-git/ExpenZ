import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:balance_checker/Presentation/views/common/IconBorderWidget.dart';
import 'package:balance_checker/Presentation/views/common/CustomDialog.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TapperWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/Presentation/views/syncsms/SyncSmsView.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/config/colors/AppColors.dart';
import '../../../floor/helper/SmsDBRepo.dart';
import '../../../locator.dart';
import '../../../utils/common/CommonUtils.dart';
import '../../cubit/localsms/SmsListResult.dart';
import '../common/CustomRoundedButton.dart';

class SmsPermissionView extends StatelessWidget {

  SmsPermissionView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _smsPermissionView(context);
  }

  Widget _smsPermissionView(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            color: AppColors.background,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                children: [
                  Expanded(flex: 1, child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Image.asset('assets/images/appicon.png', height: 39, width: 200,),
                    ),
                  )),
                  Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRect(
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    height: 200,
                                    width: 350,
                                    child: Image.asset('assets/images/smslist.png', height: 200, width: 200,),)),
                            ),
                            SpaceWidget(height: 15,),
                            TextWidget(str: AppStrings.firstTimeNoSmsPermissionHead, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 16, maxLine: 2, alignment: Alignment.center,),
                            SpaceWidget(height: 15,),
                            TextWidget(str: AppStrings.firstTimeNoSmsPermissionSubHead, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 14, maxLine: 5, alignment: Alignment.center,),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15, left: 20, right: 20),
                      child: CustomRoundedButton(btnText: AppStrings.firstTimeButtonHead,
                          btnColor: AppColors.indicatorColor,
                          btnTxtStyle: roundBtnTxtTheme(),
                          btnIcon: FaIcon(FontAwesomeIcons.userCheck, color: Colors.white, size: 17,),
                          btnCallback: () => { _checkIfPermissionAvailable(context) }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.all(15),
            height: 42,
            width: 42,
            child: TapperWidget(
                callback: () { closeApp(); },
                child: IconBorderWidget(accentColor: AppColors.iconDarkColor, icon: FontAwesomeIcons.xmark, iconSize: 25,)),
          ),
        )
      ],
    );
  }

  _showNoSmsPermissionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => CustomDialog(
        title: AppStrings.smsPermissionDeniedHead,
        message: AppStrings.smsPermissionDeniedBody,
        actions: [
          TextButton(
            child: Text(AppStrings.cancel, style: TextStyle(color: AppColors.smsTextSecondaryColor),),
            onPressed: () => {
              Navigator.of(ctx).pop()
            },
          ),
          TextButton(
              child: Text(AppStrings.allow, style: TextStyle(color: AppColors.indicatorColor),),
              onPressed: () async => {
                await Permission.sms.request().isGranted,
                Navigator.of(ctx).pop(),
              }
          ),
        ],
      ),
    );
  }

  _showNoSmsPermissionPermanentDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => CustomDialog(
        title: AppStrings.smsPermissionDeniedHead,
        message: AppStrings.smsPermissionPermanentDeniedBody,
        actions: [
          TextButton(
              child: Text(AppStrings.openSetting, style: TextStyle(color: AppColors.indicatorColor),),
              onPressed: () => {
                AppSettings.openAppSettings(type: AppSettingsType.settings),
                Navigator.of(ctx).pop(),
              }
          ),
        ],
      ),
    );
  }

  _checkIfPermissionAvailable(BuildContext context) async {
    if (Platform.isAndroid){
      if (await Permission.sms.isGranted) {
        _goToSyncSmsScreen(context);
      } else {
        _requestSmsPermission(context);
      }
    } else {
      _goToSyncSmsScreen(context);
    }
  }

  _requestSmsPermission(BuildContext context) async {
    await Permission.sms.onGrantedCallback(() {
      _goToSyncSmsScreen(context);
    }).onDeniedCallback(() {
      _showNoSmsPermissionDialog(context);
    }).onPermanentlyDeniedCallback(() {
      _showNoSmsPermissionPermanentDialog(context);
    }).request();
  }

  _goToSyncSmsScreen(BuildContext context) {
    replaceNextPage(context, MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SmsListResult(locator<SmsDBRepo>(),),),
        ],
        child: SyncSmsView()
    ));
  }
}