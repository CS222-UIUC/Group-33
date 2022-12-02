import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:semaphoreci_flutter_demo/util/color_constant.dart';

class BackgroundMoodSpot extends CustomPainter{
  final Path  unionPath  = Path();
  final Paint unionPaint = Paint();
  final Path  upperCirclePath  = Path();
  final Paint upperCirclePaint = Paint();
  final Path  lowerCirclePath  = Path();
  final Paint lowerCirclePaint = Paint();

  static const double imageOffset = 599;

  BackgroundMoodSpot(){

    // colors
    unionPaint.color             = const Color(0xFF1070f8);
    upperCirclePaint.color       = const Color(0xFF81b2fe);
    lowerCirclePaint.color       = const Color(0xFF81b2fe);

    // union path
    unionPath.moveTo(0, 0);
    unionPath.lineTo(537, 0);
    unionPath.lineTo(537, 1735);
    unionPath.cubicTo(344.778, 1716.733, 140.543, 1627.229, 0, 1403);
    unionPath.close();

    // upper circle
    upperCirclePath.moveTo(0, 135);
    upperCirclePath.arcToPoint(
      const Offset(0,615),
      radius: const Radius.circular(375),
      largeArc: true,
    );
    upperCirclePath.close();

    // lower circle
    lowerCirclePath.moveTo(703, 1329);
    lowerCirclePath.lineTo(1197, 1329);
    lowerCirclePath.lineTo(1197, 1047);
    lowerCirclePath.arcToPoint(
      const Offset(703, 1329),
      radius: const Radius.circular(320),
      clockwise: false,
    );
    lowerCirclePath.close();
  }

  // helper to compute transformation matrix
  Float64List _genMatrix({
    double skewX = 1,
    double skewY = 1,
    double translateX = 0,
    double translateY = 0,
  }){
    final m = Matrix4.identity();
    m.translate(translateX, translateY);
    m.scale(skewX, skewY);
    return m.storage;
  }

  // the goal with this is to make a background photo that can
  // dynamically resize
  @override
  void paint(Canvas canvas, Size size){

    final scaleFactor = size.height/1008;
    // so now we should be able to translate rotate or do what ever with these
    final unionTransform = _genMatrix(
      skewX: size.width / unionPath.getBounds().width,
      skewY: .4 * scaleFactor,
    );

    final upperCircleTransform = _genMatrix(
      skewX: .5 * scaleFactor,
      skewY: .5 * scaleFactor,
      translateY: 339 * scaleFactor,
    );
    final lowerCircleTransform = _genMatrix(
      skewX: .5 * scaleFactor,
      skewY: .5 * scaleFactor,
      translateX: size.width - imageOffset * scaleFactor,
      translateY: 344 * scaleFactor,
    );

    // drawing
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = ColorConstant.greenA400,
    );
    canvas.drawPath(
      unionPath.transform(unionTransform), unionPaint,
    );
    canvas.drawPath(
      upperCirclePath.transform(upperCircleTransform), upperCirclePaint,
    );
    canvas.drawPath(
      lowerCirclePath.transform(lowerCircleTransform), lowerCirclePaint,
    );

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}
