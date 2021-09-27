// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:evrka_case/customWidgets/custColors.dart';

class MapDialog extends StatelessWidget {
  const MapDialog({
    Key? key,
    required this.context,
    required this.widget,
    required this.hratio,
  }) : super(key: key);

  final BuildContext context;
  final Widget widget;
  final double hratio;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * hratio,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: light,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 1.5,
              blurRadius: 8,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
        child: widget);
  }
}
