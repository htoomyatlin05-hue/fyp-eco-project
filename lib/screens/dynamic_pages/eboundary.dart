import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';


class Dynamicscopesofemissions extends StatefulWidget {
  final VoidCallback settingstogglee;
  const Dynamicscopesofemissions({super.key, 
  required this.settingstogglee});

  @override
  State<Dynamicscopesofemissions> createState() => _DynamicscopesofemissionsState();
}

class _DynamicscopesofemissionsState extends State<Dynamicscopesofemissions> {
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