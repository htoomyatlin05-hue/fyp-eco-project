import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';

//--Icon that returns to previous page--
class BackIcon extends StatelessWidget {

  const BackIcon ({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    IconButton(onPressed: () => Navigator.pop(context),
    icon: Icon(Icons.arrow_back),
    color: Apptheme.iconslight,
    iconSize: 30,
    );
  }
}

//--Icon that returns to home page--
class ToHome extends StatelessWidget {

  const ToHome ({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    IconButton(onPressed: () { Navigator.popUntil(context,(route)=>route.isFirst);},
    icon: Icon(Icons.home),
    color: Apptheme.iconslight,
    iconSize: 30,
    );
  }
}

//--Log out button--
class Loggingout extends StatelessWidget {

  const Loggingout({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    IconButton( 
    onPressed:  () => Navigator.pushNamed(context, '/welcomepage'),
    icon: Icon(Icons.logout),
    padding: EdgeInsets.zero,
    color: Apptheme.iconslight,
    iconSize: 20,
    );
  }
}

