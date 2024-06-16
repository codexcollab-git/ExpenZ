
import 'dart:ui';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'options.dart';

@jsonSerializable
class Plots {
  String type;
  double percent;
  double amount;
  Color? color;


  Plots({required this.type, required this.percent, required this.amount, this.color});

  @override
  String toString() {
    return '{type: $type, percent: $percent, amount: $amount,}';
  }
}