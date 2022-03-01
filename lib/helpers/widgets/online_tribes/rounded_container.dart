import 'package:flutter/material.dart';


class RoundedContainer extends StatelessWidget {
  RoundedContainer({
    Key? key,
    required this.screanHeight,
    required this.screanWidth,
    this.child = const Text(''),
    this.bcColor = Colors.transparent,
    required this.height,
    required this.width,
  }) : super(key: key);
  double width;
  double height;
  double screanHeight;
  double screanWidth;
  Widget child;
  Color bcColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: bcColor,
        ),
        padding: EdgeInsets.all(20),
        child: child);
  }
}
