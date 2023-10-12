import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  goto(Widget widget) {
    return Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }
}
