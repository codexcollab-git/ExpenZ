
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@jsonSerializable
class Options {
  int id;
  String title;
  FaIcon? icon;

  Options({required this.id, required this.title, this.icon});

  @override
  String toString() {
    return '{id: $id, title: $title,}';
  }
}