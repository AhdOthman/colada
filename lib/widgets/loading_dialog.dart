import 'package:flutter/material.dart';


import 'loader_widget.dart';

loadingDialog(context) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      title: const LoaderWidget(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
