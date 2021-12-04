import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? vertialPadding;

  const BigButton(
      {required this.text,
      required this.onTap,
      this.backgroundColor,
      this.textColor,
      this.horizontalPadding,
      this.vertialPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vertialPadding ?? 32, horizontal: horizontalPadding ?? 32),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: 18,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
