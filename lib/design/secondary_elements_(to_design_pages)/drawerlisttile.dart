import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';


class Leftdrawerlisttile extends StatelessWidget {
  final String title;
  final VoidCallback? whathappens;

  const Leftdrawerlisttile({
    Key? key,
    required this.title,
    required this.whathappens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: 
        BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Apptheme.drawer,
        ),
      child: Container(
      padding: EdgeInsets.only(top: 1,bottom: 1),
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: whathappens, 
        child: 
        SizedBox(
          width: double.infinity,
          child: 
          Text(
            title,
            style: TextStyle(
              color: Apptheme.textclrlight,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
            softWrap: false,
            maxLines: 1,
          ),
        ),
      ),
    )
    );
  }
}

class Leftdrawerlisttilelight extends StatelessWidget {
  final String title;
  final VoidCallback? whathappens;

  const Leftdrawerlisttilelight({
    Key? key,
    required this.title,
    required this.whathappens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        height: 30,
        decoration: 
          BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Apptheme.drawerlight,
          ),
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        alignment: Alignment.centerLeft,
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(Icons.bookmark, size: 15,),
            ),
      
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: whathappens, 
                  child: 
                  
                    Text(
                      title,
                      style: TextStyle(
                        color: Apptheme.textclrdark,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                  
                ),
              ),
            ),
          ],
        ),
      )
      ),
    );
  }
}