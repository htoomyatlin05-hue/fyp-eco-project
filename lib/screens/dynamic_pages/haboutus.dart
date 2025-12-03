import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';


class DynamicCredits extends StatefulWidget {
  final VoidCallback settingstogglee;
  const DynamicCredits({super.key, 
  required this.settingstogglee});

  @override
  State<DynamicCredits> createState() => _DynamicCreditsState();
}

class _DynamicCreditsState extends State<DynamicCredits> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: 
          Column(
          children: [

            //--Custom Header for Home--
            Pageheaders(
              settingstogglee: null, 
              title: 'About Us', 
              child: null,
            ),
        
            
            //--Main Page--
            Expanded(
              child: Padding(padding: EdgeInsetsGeometry.all(20),
              child: null
              ),
            )
          ],
          ),
      );
  }
}