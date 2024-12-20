
import 'package:flutter/material.dart';


class CommonText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? padding;
  const CommonText(
      {super.key,
        @required this.text,
        this.textColor,
        this.fontSize,
        this.fontWeight,
        this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text??"",
        style: TextStyle(
            color: textColor ?? Colors.black,
            fontWeight: fontWeight ?? FontWeight.bold,
            fontSize: 12),
      ),
    );
  }
}