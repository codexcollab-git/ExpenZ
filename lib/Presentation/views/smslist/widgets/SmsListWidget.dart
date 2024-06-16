
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:balance_checker/Presentation/chart/DrawExpensePieChart.dart';
import 'package:balance_checker/Presentation/chart/DrawPieChart.dart';
import 'package:balance_checker/Presentation/views/common/CalenderDatePickerWidget.dart';
import 'package:balance_checker/Presentation/views/common/DropDownWidget.dart';
import 'package:balance_checker/Presentation/views/common/EmptyWidget.dart';
import 'package:balance_checker/Presentation/views/common/FilterTabWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/model/plots.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/SliverAppBarDelegate.dart';
import 'package:balance_checker/Presentation/views/syncsms/SmsLoadingWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/FilterBottomSheetWidget.dart';
import 'package:balance_checker/Presentation/views/smslist/widgets/TransactionRowWidget.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/Presentation/views/common/SpaceWidget.dart';
import 'package:balance_checker/Presentation/views/common/TextWidget.dart';
import 'package:balance_checker/utils/common/DateTimeUtils.dart';
import 'package:balance_checker/utils/config/strings/AppStrings.dart';
import 'package:balance_checker/utils/extensions/ScrollControllerExtensions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../floor/helper/SmsDBRepo.dart';
import '../../../../../locator.dart';
import '../../../../../utils/config/colors/AppColors.dart';
import '../../../../utils/common/CommonUtils.dart';
import '../../../../utils/prefs/SharedPref.dart';
import '../../../cubit/localsms/SmsListResult.dart';
import '../../common/CustomRoundedButton.dart';
import '../../common/IconBorderWidget.dart';
import '../../common/PopUpMenuTextWidget.dart';
import '../../common/TapperWidget.dart';
import '../../smspermission/SmsPermissionView.dart';
import '../../syncsms/SyncSmsView.dart';
import '../model/filter.dart';
import '../model/options.dart';

class SmsListWidget extends HookWidget {
  Filter filter;
  Filter? resetFilter;
  ScrollController? _scrollController;

  SmsListWidget(this.filter);

  @override
  Widget build(BuildContext context) {
    _setDefault();

    _scrollController = useMemoized(() => ScrollController());

    useEffect(() {
      return _scrollController?.dispose;
    }, [_scrollController]);

    return BlocBuilder<SmsListResult, SmsListState>(builder: (context, state) {
      if (state is SmsListLoading) {
        return SmsLoadingWidget();
      } else if (state is SmsListSuccess) {
        if (state.smsList.isNotEmpty && filter.isDataExist == false)  {
          filter.isDataExist = true;
        }
        print(state.smsList.length);
        return _buildTransactionList(context, state.smsList);
      } else if (state is SmsListError) {
        return Center(child: Text(state.message));
      } else {
        return SizedBox();
      }
    });
  }

  _setDefault() {
    _scrollController = useScrollController();
    if(filter.selectedDates == null) {
      filter.selectedDates = [getLastNDayTimestamp(dueDay: 30), getToday(),];
    }
    resetFilter = filter;
  }

  Widget _buildTransactionList(
      BuildContext context,
      List<SmsEntity> smsList,
      ) {
    if (!smsList.isEmpty) {
      return _buildTransactions(context, smsList.reversed.toList());
    } else {
      if (filter.isDataExist && !smsList.isEmpty) {
        return _buildTransactions(context, smsList.reversed.toList());
      } else {
        return _noTransactionFound(context);
      }
    }
  }

  Widget _buildTransactions(
    BuildContext context,
    List<SmsEntity> smsList,
  ) {
    return _checkIfListExist(context, smsList);
  }

  Widget _checkIfListExist(
      BuildContext context,
      List<SmsEntity> smsList,
      ) {
    if (!smsList.isEmpty) {
      return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _createList(context, smsList),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.all(5),
            child: FloatingActionButton(
              backgroundColor: AppColors.indicatorColor,
              elevation: 4,
              onPressed: (){
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (_) => FilterBottomSheetWidget(filter: filter, onFilterSelected: (updatedFilter) => {
                    filter = updatedFilter,
                    _reloadPage(context),
                  },),
                );
              },
              child: FaIcon(FontAwesomeIcons.arrowUpWideShort, color: Colors.white,),
            ),
          ), floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
      );
    } else {
      if (filter.isDataExist) {
        return _noFilterTransactionFound(context);
      } else {
        return _noTransactionFound(context);
      }
    }
  }

  Widget _createList(
      BuildContext context,
      List<SmsEntity> smsList,
      ) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              maxHeight: 55,
              minHeight: 55,
              child: Card(
                margin: EdgeInsets.all(0),
                elevation: 5,
                shadowColor: AppColors.borderColor,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Image.asset('assets/images/appicon.png', height: 39, width: 200,),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15,),
                    child: Container(
                      color: Colors.white,
                      height: 250,
                      child: _drawChart(smsList),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: _drawTopOptions(context),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (ctx, index) {
                  SmsEntity? prevSms = null;
                  if (index != 0) {
                    prevSms = smsList[index - 1];
                  }
                  return TransactionRowWidget(
                      key: ValueKey<int>(smsList[index].smsId ?? 0),
                      sms: smsList[index],
                      prevSms: prevSms,
                      onSmsPressed: (sms) {
                        showToast(
                          AppStrings.deletedSuccessfully,
                          backgroundColor: AppColors.toastBgColor,
                          position: ToastPosition.bottom,
                        );
                        _deleteTransaction(context, sms);
                      },
                  );
                },
                childCount: smsList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _drawChart(
      List<SmsEntity> smsList,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: DrawPieChart(key: ValueKey<int>(DateTime.now().millisecond), plots: _calculateType(smsList)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
          child: DrawExpensePieChart(key: ValueKey<int>(DateTime.now().millisecond), plots: _calculateExpense(smsList)),
        ),),
      ],
    );
  }

  List<Plots> _calculateType(
      List<SmsEntity> smsList,
      ) {
    List<Plots> plots = [];
    double sipAmt = smsList.where((sms) => (sms.transactionModeEnum == 'sip'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);
    double upiAmt = smsList.where((sms) => (sms.transactionModeEnum == 'upi'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);
    double neftAmt = smsList.where((sms) => (sms.transactionModeEnum == 'neft'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);
    double otherAmt = smsList.where((sms) => (sms.transactionModeEnum == 'other'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);

    double total = sipAmt + upiAmt + neftAmt + otherAmt;
    double sipPercent = getPercent(total, sipAmt);
    double upiPercent = getPercent(total, upiAmt);
    double neftPercent = getPercent(total, neftAmt);
    double otherPercent = getPercent(total, otherAmt);

    if(sipAmt > 0) plots.add(Plots(type: 'SIP', percent: sipPercent, amount: sipAmt));
    if(upiAmt > 0) plots.add(Plots(type: 'UPI', percent: upiPercent, amount: upiAmt));
    if(neftAmt > 0) plots.add(Plots(type: 'NEFT', percent: neftPercent, amount: neftAmt));
    if(otherAmt > 0) plots.add(Plots(type: 'Others', percent: otherPercent, amount: otherAmt));

    return plots;
  }

  List<Plots> _calculateExpense(
      List<SmsEntity> smsList,
      ) {
    List<Plots> plots = [];
    double debitAmt = smsList.where((sms) => (sms.transactionTypeEnum == 'debit'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);
    double creditAmt = smsList.where((sms) => (sms.transactionTypeEnum == 'credit'))
        .fold(0.0, (sum, sms) => sum + sms.transactionAmount!);

    double totalAmt = debitAmt + creditAmt;
    double debitPercent = getPercent(totalAmt, debitAmt);
    double creditPercent = getPercent(totalAmt, creditAmt);
    if(creditAmt > 0) plots.add(Plots(type: 'Earning', percent: creditPercent, amount: creditAmt));
    if(debitAmt > 0) plots.add(Plots(type: 'Expense', percent: debitPercent, amount: debitAmt));
    return plots;
  }

  Widget _noFilterTransactionFound(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Expanded(flex: 1, child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: Image.asset('assets/images/appicon.png', height: 38, width: 200,),
                ),
              )),
              Expanded(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRect(
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                height: 250,
                                width: 350,
                                child: Image.asset('assets/images/lost.png', height: 250, width: 250,),)),
                        ),
                        SpaceWidget(height: 15,),
                        TextWidget(str: AppStrings.noFilterHead, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 16, maxLine: 2, alignment: Alignment.center,),
                        SpaceWidget(height: 15,),
                        TextWidget(str: AppStrings.noFilterSubHead, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 14, maxLine: 5, alignment: Alignment.center,),
                      ],
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
                  child: CustomRoundedButton(btnText: AppStrings.goBack,
                      btnColor: AppColors.indicatorColor,
                      btnTxtStyle: roundBtnTxtTheme(),
                      btnIcon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 18,),
                      btnCallback: () => { _refreshSms(context) }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noTransactionFound(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Expanded(flex: 1, child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Image.asset('assets/images/appicon.png', height: 38, width: 200,),
                    ),
                  )),
                  Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRect(
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    height: 200,
                                    width: 350,
                                    child: Image.asset('assets/images/notfound.png', height: 200, width: 200,),)),
                            ),
                            SpaceWidget(height: 15,),
                            TextWidget(str: AppStrings.noTransactionsHead, txtColor: AppColors.primaryTextColor, txtFontWeight: FontWeight.w600, txtSize: 16, maxLine: 2, alignment: Alignment.center,),
                            SpaceWidget(height: 15,),
                            TextWidget(str: AppStrings.noTransactionsSubHead, txtColor: AppColors.secondaryTextColor, txtFontWeight: FontWeight.w400, txtSize: 14, maxLine: 5, alignment: Alignment.center,),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
                      child: CustomRoundedButton(btnText: AppStrings.refresh,
                          btnColor: AppColors.indicatorColor,
                          btnTxtStyle: roundBtnTxtTheme(),
                          btnIcon: FaIcon(FontAwesomeIcons.arrowsRotate, color: Colors.white, size: 18,),
                          btnCallback: () => { _refreshSms(context) }
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
            margin: EdgeInsets.all(20),
            height: 39,
            width: 39,
            child: TapperWidget(callback: () { closeApp(); },
                child: IconBorderWidget(accentColor: AppColors.iconDarkColor, icon: FontAwesomeIcons.xmark, iconSize: 22,)),
          ),
        )
      ],
    );
  }

  _refreshSms(BuildContext context) {
    _checkIfPermissionAvailable().then((isAvailable) {
      if (isAvailable) {
        return _goToSyncSmsScreen(context);
      } else {
        return replaceNextPage(context, SmsPermissionView());
      }
    });
  }

  _goToSyncSmsScreen(BuildContext context) {
    replaceNextPage(context, MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SmsListResult(locator<SmsDBRepo>(),),),
        ],
        child: SyncSmsView()
    ));
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

  _drawTopOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CalenderDatePickerWidget(selectedDates: filter.selectedDates!, onDateSelected: (selectedDate) => {
            filter.selectedDates = selectedDate,
            _reloadPage(context),
          },),
          SpaceWidget(width: 10,),
          TapperWidget(
              circleRadius: 15,
              callback: () { _refreshSms(context); },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FaIcon(
                    FontAwesomeIcons.rotate, color: AppColors.indicatorColor, size: 16,),
                ),
              )),
        ],
      ),
    );
  }

  _deleteTransaction(BuildContext context, SmsEntity sms){
    context.read<SmsListResult>().hideSms(id: sms.smsId ?? 0, filter: filter);
  }

  _reloadPage(BuildContext context){
    print(filter);
    context.read<SmsListResult>().refresh(filter: filter);
  }
}