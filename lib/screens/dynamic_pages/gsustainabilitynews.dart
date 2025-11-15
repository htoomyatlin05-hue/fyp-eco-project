import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';


class DynamicSustainabilityNews extends StatefulWidget {
  final VoidCallback settingstogglee;
  const DynamicSustainabilityNews({super.key, 
  required this.settingstogglee});

  @override
  State<DynamicSustainabilityNews> createState() => _DynamicProfileState();
}

class _DynamicProfileState extends State<DynamicSustainabilityNews> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: 
          Column(
          children: [

            //--Custom Header for Home--
            PageHeaderFour(title: 'Sustainability News',
            summary: 'Type here', 
            whathappens: widget.settingstogglee,
            color: Apptheme.auxilary
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