
import 'package:flutter/material.dart';

class SpaceWidget extends StatelessWidget {
  final double width;
  final double height;

  SpaceWidget({this.width = 0, this.height = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height,);
  }
}

