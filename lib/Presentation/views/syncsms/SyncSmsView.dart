
import 'dart:async';
import 'dart:math';
import 'package:balance_checker/Presentation/views/smslist/widgets/SmsListWidget.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:balance_checker/smsparser/mapper/sms_mapper.dart';
import '../../../../floor/helper/SmsDBRepo.dart';
import '../../../../locator.dart';
import '../../../../utils/config/colors/AppColors.dart';
import '../../../../smsparser/core/engine.dart';
import '../../../../smsparser/model/types.dart';
import '../../../utils/common/CommonUtils.dart';
import '../../../utils/prefs/SharedPref.dart';
import '../../cubit/localsms/SmsListResult.dart';
import '../smslist/SmsListView.dart';

class SyncSmsView extends StatelessWidget {

  SyncSmsView({Key? key,}) : super(key: key);
  late SharedPref pref;

  @override
  Widget build(BuildContext context) {
    pref = GetIt.instance<SharedPref>();
    return callData(context);
  }

  callData(BuildContext context) {
    final smsCubit = BlocProvider.of<SmsListResult>(context);
    Timer(const Duration(seconds: 2), () {
      _fetchAllSms(context, smsCubit);
    });
    return _createProgressView(context);
  }

  _createProgressView(BuildContext context) {
    Map<String, String> randomQuote = getRandomQuote();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(flex: 1, child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Image.asset('assets/images/appicon.png', height: 38, width: 200,),
            ),
          )),
          Expanded(flex: 6, child: Container(
            color: AppColors.background,
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Center(
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
                              child: Lottie.asset('assets/animation/sync_anim.json', fit: BoxFit.cover))),
                    ),
                    SpaceWidget(height: 15,),
                    TextWidget(str: AppStrings.inProgressScreenHead, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 16, maxLine: 2, alignment: Alignment.center,),
                  ],
                ),
              ),
            ),
          )),
          Expanded(flex: 3, child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Center(
              child: Column(
                children: [
                  TextWidget(str: randomQuote['title'] ?? '', txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 15, maxLine: 2, alignment: Alignment.center,),
                  SpaceWidget(height: 15,),
                  TextWidget(str: "- ${randomQuote['by']}", txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 14, maxLine: 2, alignment: Alignment.center,),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  _fetchAllSms(BuildContext context, SmsListResult smsCubit) async {
    SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.getAllSms;
    List<SmsEntity> smsEntities = await compute(_processSmsMessages, messages);
    for (var element in smsEntities) {
      smsCubit.insertSms(sms: element);
    }
    _goToSmsList(context, smsCubit);
  }

  List<SmsEntity> _processSmsMessages(List<SmsMessage> messages) {
    List<SmsEntity> smsEntities = [];
    for (var element in messages) {
      String? message = element.body;
      RegExp regex = RegExp('[a-zA-Z0-9]{2}-[a-zA-Z0-9]{6}', caseSensitive: false);
      if (message != null && regex.hasMatch(element.sender!)) {
        TransactionInfo? obj = getTransactionInfo(element);
        if (obj != null) {
          SmsEntity? smsEntity = mapSmsToSmsEntity(transaction: obj.transactionDetail, account: obj.account,
              transactionType: obj.transactionType, balance: obj.balance,
              transactionModeEnum: obj.transactionModeEnum, dateTime: obj.dateTime);
          if (smsEntity != null) {
            smsEntities.add(smsEntity);
          }
        }
      }
    }
    return smsEntities;
  }

  _goToSmsList(BuildContext context, SmsListResult smsCubit) {
    var pref = GetIt.instance<SharedPref>();
    pref.firstSyncComplete = true;
    pref.lastSyncTime = DateTime.now().millisecondsSinceEpoch;
    /*replaceNextPage(context, MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SmsListResult(locator<SmsDBRepo>(),)..getAllSms(),),
        ],
        child: SmsListView()
    ));*/
    replaceNextPage(context, SmsListView());
  }

  Map<String, String> getRandomQuote() {
    final random = Random();
    int randomIndex = random.nextInt(AppStrings.quotes.length);
    return AppStrings.quotes[randomIndex];
  }
}