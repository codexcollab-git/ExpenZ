
import 'dart:async';
import 'package:balance_checker/Presentation/cubit/localsms/SmsListResult.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:balance_checker/floor/entities/SmsEntity.dart';
import 'package:balance_checker/floor/helper/SmsDBRepo.dart';

part 'LastSmsTimestampState.dart';

class LastSmsTimestampResult extends Cubit<LastSmsTimestampState> {
  final SmsDBRepo _dbRepo;

  LastSmsTimestampResult(this._dbRepo) : super(const LastSmsTimestampLoading());

  Future<void> getLastSmsTimeStamp() async {
    emit(await _getLastSmsTimeStamp());
  }

  Future<LastSmsTimestampState> _getLastSmsTimeStamp() async {
    final timestamp = await _dbRepo.getLastSmsTimeStamp();
    return LastSmsTimestampSuccess(lastTimestamp: timestamp);
  }
}
