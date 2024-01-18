import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ContextUtilities on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Future<void> showMyDialog(Widget widget) async {
    return showDialog<void>(
      context: this,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  // Navigation's
  Future<dynamic> push(
      {required Widget child, bool rootNavigator = false}) async {
    return await Navigator.of(this, rootNavigator: rootNavigator).push(
      MaterialPageRoute(builder: (ctx) => child),
    );
  }

  Future<dynamic> pushAndRemoveUntil(
      {required Widget child, bool rootNavigator = false}) async {
    return await Navigator.of(this, rootNavigator: rootNavigator)
        .pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => child,
            ),
            (route) => false);
  }

  void pop({dynamic data, bool rootNavigator = false}) {
    Navigator.of(this, rootNavigator: rootNavigator).pop(data);
  }

  bool canPop() => Navigator.of(this).canPop();

  // provider

  T provider<T>() {
    return Provider.of<T>(this, listen: false);
  }
}

// extension ColorToMaterialStateProperty on Color {
//   MaterialStateProperty<Color?>? toMaterialStateProperty() {
//     return MaterialStateProperty.all(this);
//   }
// }

extension ToMaterialStateProperty<T> on T {
  MaterialStateProperty<T?> toMaterialStateProperty() {
    return MaterialStateProperty.resolveWith((_) => this);
  }
}
