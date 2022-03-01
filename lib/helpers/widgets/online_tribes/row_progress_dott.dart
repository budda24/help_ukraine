import 'package:flutter/cupertino.dart';

class RowProgressDots extends StatelessWidget {
  const RowProgressDots({
    Key? key,
    required this.screeanheight,
    required this.screeanwidth,
    required this.dott1,
    required this.dott2,
    required this.dott3,
  }) : super(key: key);

  final double screeanheight;
  final double screeanwidth;
  final Color dott1;
  final Color dott2;
  final Color dott3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            progressDots(color: dott1,
                screeanheight: screeanheight,
                screeanwidth: screeanwidth),

            progressDots(color: dott2,
                screeanheight: screeanheight,
                screeanwidth: screeanwidth),

            progressDots(color: dott3,
                screeanheight: screeanheight,
                screeanwidth: screeanwidth),
          ]
      ),
    );
  }
}

class progressDots extends StatelessWidget {
  const progressDots({
    Key? key,
    required this.color,
    required this.screeanheight,
    required this.screeanwidth,

  }) : super(key: key);

  final double screeanheight;
  final double screeanwidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screeanheight * 0.05,
      width: screeanwidth * 0.05,
      decoration:
      BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}