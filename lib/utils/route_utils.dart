import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void pushPage(BuildContext context, bool isCupertino, Widget page) {
  if (isCupertino) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => page));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
