
part of 'SmsListResult.dart';

abstract class SmsListState extends Equatable {
  const SmsListState();
  @override
  List<Object> get props => [];
}

class InitialState extends SmsListState { }

class SmsListLoading extends SmsListState { }

class SmsListSuccess extends SmsListState {
  final List<SmsEntity> smsList;
  SmsListSuccess(this.smsList);
  @override
  List<Object> get props => [smsList];
}

class SmsListError extends SmsListState {
  final String message;
  SmsListError(this.message);
  @override
  List<Object> get props => [message];
}