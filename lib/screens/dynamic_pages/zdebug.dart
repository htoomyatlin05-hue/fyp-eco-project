import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';


class DebugPage extends StatefulWidget {
  final VoidCallback settingstogglee;
  final VoidCallback menutoggle;

  const DebugPage({super.key, 
  required this.settingstogglee,
  required this.menutoggle,
  });

  @override
  State<DebugPage> createState() => _DynamicProfileState();
}

class _DynamicProfileState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return PrimaryPages(
      menutogglee: widget.menutoggle, 
      header: Pageheaders(
        settingstogglee: widget.settingstogglee, 
        title: 'Test Screen', 
        child: null
      ),
      childofmainpage: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: Apptheme.widgetsecondaryclr,
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Apptheme.accent1,
            ),
          ],
        ),
      ),
    );
  }
}