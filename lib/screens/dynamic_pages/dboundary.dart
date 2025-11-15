import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';


class Dynamicboundary extends StatefulWidget {
  final VoidCallback settingstogglee;
  const Dynamicboundary({super.key, required this.settingstogglee});

  @override
  State<Dynamicboundary> createState() => _DynamicboundaryState();
}

class _DynamicboundaryState extends State<Dynamicboundary> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: 
          Column(
          children: [

            //--Custom Header for Home--
            PageHeaderFour(title: 'Boundary', 
            summary: 'Type here', 
            color: Apptheme.auxilary,
            whathappens: widget.settingstogglee,
            ),
        
            
            //--Main Page--
            Expanded(
              child: Padding(padding: EdgeInsetsGeometry.all(20),
              child: null
              )
            ),
          ],),
      );
  }
}