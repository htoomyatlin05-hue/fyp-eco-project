import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';


class LShapeClipper extends CustomClipper<Path> {
  final double verticalWidth;
  final double horizontalHeight;
  final double outerRadius;
  final double innerRadius;
  final double heightsubtract;

  LShapeClipper({
    required this.verticalWidth,
    required this.horizontalHeight,
    this.outerRadius = 20,
    this.innerRadius = 20,
    this.heightsubtract= 400
  });

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final heightoffset = heightsubtract;

    final vw = verticalWidth;
    final hh = horizontalHeight;

    final maxOuterRadius = (h - horizontalHeight - heightoffset) / 2;
    final maxInnerRadius = (h - horizontalHeight - heightoffset) / 2;

    final or = outerRadius.clamp(0, maxOuterRadius);
    final ir = innerRadius.clamp(0, maxInnerRadius);

    final path = Path();

    path.moveTo(0, heightoffset);

    path.lineTo(vw - or, heightoffset);
    path.quadraticBezierTo(vw, heightoffset, vw, heightoffset+or);

    path.lineTo(vw , h - (hh+ir));
    path.quadraticBezierTo(vw, h - (hh), vw+ir, h- hh);

    path.lineTo(vw+ir , h - hh);

    path.lineTo(w, h-hh);

    path.lineTo(w, h);

    path.lineTo(0, h);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class LShapeContainer extends StatelessWidget {
  final double verticalWidth;
  final double horizontalHeight;
  final double outerRadius;
  final double innerRadius;

  final Gradient? gradient;
  final DecorationImage? image;
  final Widget? child;

  const LShapeContainer({
    super.key,
    required this.verticalWidth,
    required this.horizontalHeight,
    this.outerRadius = 50,
    this.innerRadius = 50,
    this.gradient,
    this.image,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LShapeClipper(
        verticalWidth: verticalWidth,
        horizontalHeight: horizontalHeight,
        outerRadius: outerRadius,
        innerRadius: innerRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Apptheme.auxilary,
          gradient: gradient,
          image: image,
        ),
        child: child,
      ),
    );
  }
}
