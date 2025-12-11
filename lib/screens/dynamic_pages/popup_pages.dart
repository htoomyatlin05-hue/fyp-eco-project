import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'dart:ui';





//-------------------------------------GENERAL-------------------------------------------------------
class GeneralPage extends StatelessWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Labels(
        title: "General Settings Page Content",
        color: Apptheme.textclrlight,
        fontsize: 20,
      ),
    );
  }
}

//-------------------------------------UNITS-------------------------------------------------------
class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Labels(
        title: "Units Settings Page Content",
        color: Apptheme.textclrlight,
        fontsize: 20,
      ),
    );
  }
}

//-------------------------------------REUSEABLE TRANSLUCENT BACKGROUND----------------------------
class FrostedBackgroundGeneral extends StatelessWidget {
  final Widget child;
  const FrostedBackgroundGeneral({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Apptheme.backgrounddark.withOpacity(0.6),
          child: child,
        ),
      ),
    );
  }
}

















