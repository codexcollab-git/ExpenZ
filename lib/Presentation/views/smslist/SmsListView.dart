
import 'dart:async';
import 'dart:io';
import 'package:balance_checker/Presentation/views/common/FilterTabWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/FilterBottomSheetWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/SmsListWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/TransactionRowWidget.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:balance_checker/utils/extensions/ScrollControllerExtensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../floor/helper/SmsDBRepo.dart';
import '../../../../locator.dart';
import '../../../../utils/config/colors/AppColors.dart';
import '../../../utils/common/CommonUtils.dart';
import '../../cubit/localsms/SmsListResult.dart';
import '../common/CustomRoundedButton.dart';
import '../common/IconBorderWidget.dart';
import '../common/TapperWidget.dart';
import '../smspermission/SmsPermissionView.dart';
import '../syncsms/SyncSmsView.dart';
import 'model/filter.dart';

class SmsListView extends StatefulWidget {
  @override
  _SmsListView createState() => _SmsListView();
}

class _SmsListView extends State<SmsListView> {
  late Filter filter = Filter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SmsListResult(locator<SmsDBRepo>(),)..getAllSms(filter: filter),),
      ],
      child: SmsListWidget(filter),
    );
  }
}