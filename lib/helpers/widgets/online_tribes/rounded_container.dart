import 'package:flutter/material.dart';
import 'package:pomoc_ukrainie/helpers/theme/app_colors.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.borderCoplor,
    this.child = const Text(''),
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);
  double width;
  double height;
  Widget child;
  Color backgroundColor;
  Color borderCoplor;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: Border.all(
            color: borderCoplor,
            width: 3,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: child);
  }
}
