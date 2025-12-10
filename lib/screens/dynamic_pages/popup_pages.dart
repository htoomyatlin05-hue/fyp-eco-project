import 'package:flutter/material.dart';
import 'dart:math';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';

void showSettingsPopup(BuildContext context) {

  showGeneralDialog(
    context: context,
    barrierLabel: "Popup",
    barrierDismissible: true,
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.9, end: 1.0).animate(curved),
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 70,
                right: 10,
                bottom: 70,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Apptheme.backgroundlight,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: SettingsContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenwidth = mediaQueryData.size.width;

    double padding = 20;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: Apptheme.drawer,
                  width: 200,
                  child: Labels(
                    title: 'First', 
                    color: Apptheme.textclrlight
                  ),
                ),
              )
            ],
          ),

          SizedBox(width: padding,),

          Column(
            children: [
              Expanded(
                child: Container(
                  color: Apptheme.drawer,
                  width: max(0, screenwidth-80-(padding*3)-200),
                  //-- (screenwidth-positionedoffset-totalpadding-widthofother)--
                  child: Labels(
                    title: 'Second Column', 
                    color: Apptheme.textclrlight
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
