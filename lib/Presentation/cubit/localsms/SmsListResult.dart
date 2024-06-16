
import 'dart:async';
import 'package:balance_checker/Presentation/views/smslist/model/filter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/floor/helper/SmsDBRepo.dart';

part 'SmsListState.dart';

class SmsListResult extends Cubit<SmsListState> {
  final SmsDBRepo _dbRepo;

  SmsListResult(this._dbRepo) : super(InitialState());

  Future<void> insertSms({required SmsEntity sms}) async {
    await _dbRepo.insertSms(sms);
  }

  void hideSms({required int id, Filter? filter = null}) async {
    emit(SmsListLoading());
    try {
      await _dbRepo.hideSms(id);
      final smsList = await _dbRepo.getAllSms(filter);
      emit(SmsListSuccess(smsList));
    } catch (e) {
      emit(SmsListError(e.toString()));
    }
  }

  void getAllSms({Filter? filter = null}) async {
    emit(SmsListLoading());
    try {
      final smsList = await _dbRepo.getAllSms(filter);
      emit(SmsListSuccess(smsList));
    } catch (e) {
      emit(SmsListError(e.toString()));
    }
  }

  void refresh({Filter? filter = null}) async {
    emit(SmsListLoading());
    try {
      final smsList = await _dbRepo.getAllSms(filter);
      emit(SmsListSuccess(smsList));
    } catch (e) {
      emit(SmsListError(e.toString()));
    }
  }
}
