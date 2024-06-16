
import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../../../../utils/common/DateTimeUtils.dart';
import 'options.dart';

@jsonSerializable
class Filter {
  String? from;
  String? type;
  bool isDataExist;
  List<DateTime?>? selectedDates;

  Filter({this.from, this.isDataExist = false, this.type, this.selectedDates});

  @override
  String toString() {
    return '{from: $from, type: $type, isDataExist: $isDataExist, selectedDates: ${selectedDates.toString()} }';
  }
}