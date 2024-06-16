import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/config/colors/AppColors.dart';

class LoadingWidgetDirect {
  late BuildContext context;

  LoadingWidgetDirect(this.context);

  // this is where you would do your fullscreen loading
  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(color: AppColors.tagChipColor)
                  : const CupertinoActivityIndicator(
                    color: AppColors.tagChipColor, radius: 20, animating: true,),
            ),
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }
}
