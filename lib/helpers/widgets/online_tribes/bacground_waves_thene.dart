import 'package:flutter/cupertino.dart';
import '../../../helpers/main_constants.dart';

class GreenWaves2 extends StatelessWidget {
   GreenWaves2({
    /*Key? key,*/
    required this.screeanheight,
    /*required this.bezierClipper,*/
  })/* : super(key: key)*/;
  /*CustomClipper BezierClipper2();*/
  final double screeanheight;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BezierClipper2(),
      child: Container(
        color: kMainColor,
        height: screeanheight * 0.51,
      ),
    );
  }
}
class BezierClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 480.5;
    final double _yScaling = size.height / 500;
    path.lineTo(-16.522000000000048 * _xScaling, 405.615 * _yScaling);
    path.cubicTo(
      23.126999999999953 * _xScaling,
      421.798 * _yScaling,
      55.29899999999998 * _xScaling,
      381.415 * _yScaling,
      138.92599999999993 * _xScaling,
      397.258 * _yScaling,
    );
    path.cubicTo(
      201.11299999999994 * _xScaling,
      409.043 * _yScaling,
      210.2639999999999 * _xScaling,
      436.481 * _yScaling,
      265.9609999999999 * _xScaling,
      446.844 * _yScaling,
    );
    path.cubicTo(
      331.4469999999999 * _xScaling,
      459.03200000000004 * _yScaling,
      400.4919999999999 * _xScaling,
      436.3 * _yScaling,
      439.2389999999999 * _xScaling,
      407.286 * _yScaling,
    );
    path.cubicTo(
      551.115 * _xScaling,
      323.509 * _yScaling,
      569.9739999999999 * _xScaling,
      67.84500000000003 * _yScaling,
      418.62399999999997 * _xScaling,
      -61.84499999999997 * _yScaling,
    );
    path.cubicTo(
      295.303 * _xScaling,
      -167.51499999999993 * _yScaling,
      96.94799999999998 * _xScaling,
      -157.01999999999992 * _yScaling,
      -14.851000000000113 * _xScaling,
      -45.12899999999996 * _yScaling,
    );
    path.cubicTo(
      -162.98400000000004 * _xScaling,
      103.12600000000003 * _yScaling,
      -100.96100000000001 * _xScaling,
      371.154 * _yScaling,
      -16.522000000000048 * _xScaling,
      405.615 * _yScaling,
    );
    path.cubicTo(
      -16.522000000000048 * _xScaling,
      405.615 * _yScaling,
      -16.522000000000048 * _xScaling,
      405.615 * _yScaling,
      -16.522000000000048 * _xScaling,
      405.615 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class GreenWaves1 extends StatelessWidget {
  GreenWaves1({
    /*Key? key,*/
    required this.screeanheight,
    /*required this.bezierClipper,*/
  })/* : super(key: key)*/;
  /*CustomClipper BezierClipper2();*/
  final double screeanheight;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BezierClipper1(),
      child: Container(
        color: kMainColor,
        height: screeanheight * 0.51,
      ),
    );
  }
}
class BezierClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 450.5;
    final double _yScaling = size.height / 500;
    path.lineTo(-85.594 * _xScaling,376.801 * _yScaling);
    path.cubicTo(-32.34899999999999 * _xScaling,402.101 * _yScaling,36.33500000000001 * _xScaling,357.529 * _yScaling,127.869 * _xScaling,408.644 * _yScaling,);
    path.cubicTo(158.292 * _xScaling,425.632 * _yScaling,155.77900000000002 * _xScaling,433.39 * _yScaling,179.76000000000002 * _xScaling,445.204 * _yScaling,);
    path.cubicTo(262.49800000000005 * _xScaling,485.963 * _yScaling,394.283 * _xScaling,443.826 * _yScaling,461.626 * _xScaling,369.726 * _yScaling,);
    path.cubicTo(565.69 * _xScaling,255.221 * _yScaling,542.518 * _xScaling,35.069 * _yScaling,417.99 * _xScaling,-81.96600000000001 * _yScaling,);
    path.cubicTo(268.158 * _xScaling,-222.781 * _yScaling,-2.5660000000000025 * _xScaling,-190.02800000000002 * _yScaling,-113.899 * _xScaling,-31.254 * _yScaling,);
    path.cubicTo(-213.61599999999999 * _xScaling,110.956 * _yScaling,-172.367 * _xScaling,335.58 * _yScaling,-85.594 * _xScaling,376.801 * _yScaling,);
    path.cubicTo(-85.594 * _xScaling,376.801 * _yScaling,-85.594 * _xScaling,376.801 * _yScaling,-85.594 * _xScaling,376.801 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
