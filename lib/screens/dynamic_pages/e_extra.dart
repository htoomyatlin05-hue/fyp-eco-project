import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';


class Dynamicextra extends StatefulWidget {
  final VoidCallback settingstogglee;
  const Dynamicextra({super.key, 
  required this.settingstogglee});

  @override
  State<Dynamicextra> createState() => _DynamicextraState();
}

class _DynamicextraState extends State<Dynamicextra> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: 
          Column(
          children: [

            //--Custom Header for Home--
            PageHeaderFour(title: 'Boundary',
            summary: 'Type here', 
            whathappens: widget.settingstogglee,
            color: Apptheme.auxilary,
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