
part of 'LastSmsTimestampResult.dart';

abstract class LastSmsTimestampState extends Equatable {
  final int? lastTimestamp;

  const LastSmsTimestampState({
    this.lastTimestamp = 0,
  });

  @override
  List<int?> get props => [lastTimestamp];
}

class LastSmsTimestampLoading extends LastSmsTimestampState {
  const LastSmsTimestampLoading();
}

class LastSmsTimestampSuccess extends LastSmsTimestampState {
  const LastSmsTimestampSuccess({super.lastTimestamp});
}
