import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';


//--Texts inside tab labels--
class Tabtext extends StatefulWidget {
  final String words;
  final double specifysize;
  const Tabtext({Key? key, required this.words, required this.specifysize}) : super(key: key);


  @override
  State<Tabtext> createState() => _TabtextState();
}

class _TabtextState extends State<Tabtext> {
  @override
  Widget build(BuildContext context) {
    return 
    Center(
      child:
      Text( widget.words,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: widget.specifysize,
        color: Apptheme.textclrlight,
        fontWeight: FontWeight.bold
      ),
      )
    );
  }
}


//--Texts inside Setting drawer--
class Stgdrawertext extends StatelessWidget {
  final String title;

  const Stgdrawertext({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  
    Container(
      padding: EdgeInsets.only(left: 10),
      child: 
      Text(title,
        style: TextStyle(
          color: Apptheme.textclrdark,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
      );

  }
}


//--Textfield for sensitive info--
class Typeheresensitive extends StatefulWidget {
  final String title;
  const Typeheresensitive({Key? key, required this.title}) : super(key: key);

  @override
  State<Typeheresensitive> createState() => _TypeheresensitiveState();
}

class _TypeheresensitiveState extends State<Typeheresensitive> {

  @override
  Widget build(BuildContext context) {
    return 

            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: 
                TextField(  
                obscureText: true,
                obscuringCharacter: '*',


                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Apptheme.textclrdark,),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 0),
                  hintText: widget.title,
                  hintStyle: TextStyle(
                    color: Apptheme.texthintclrdark,
                    fontSize: 16,
                    fontWeight: FontWeight.w100,

                  ),
                ),
              )
            );
  }
}


//--Textfield for general info--
class Typehere extends StatefulWidget {
 final String title;
  const Typehere({Key? key, required this.title}) : super(key: key);

  @override
  State<Typehere> createState() => _TypehereState();
}

class _TypehereState extends State<Typehere> {

  @override
  Widget build(BuildContext context) {
    return 
    Align(
      alignment: AlignmentGeometry.centerLeft,
      child: 
        TextField(  
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500 ,
            color: Apptheme.textclrdark,
          ),
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 0),
          hintText: widget.title,
          hintStyle: TextStyle(
            color: Apptheme.texthintclrdark,
            fontSize: 16,
            fontWeight: FontWeight.w100,

          ),
        ),
      )
    );
  }
}


//--Big Focused Text--
class Bigfocusedtext extends StatefulWidget {
  const Bigfocusedtext({super.key});

  @override
  State<Bigfocusedtext> createState() => _BigfocusedtextState();
}

class _BigfocusedtextState extends State<Bigfocusedtext> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text('S P H E R E',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Apptheme.textclrspecial,
      ),
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      ),
    );
  }
}


//--Summaries in each page--
class Subtitlesummary extends StatefulWidget {
  final String words;
  final Color color;
  const Subtitlesummary({super.key, required this.words, required this.color});

  @override
  State<Subtitlesummary> createState() => _SubtitlesummaryState();
}

class _SubtitlesummaryState extends State<Subtitlesummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text( widget.words,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Apptheme.textclrspecial,
      ),
      overflow: TextOverflow.fade,
      maxLines: 6,
      softWrap: true,
      ),
    );
  }
}


class Labels extends StatelessWidget {
  final String title;
  const Labels({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( builder: (BuildContext context, BoxConstraints constraints) {
      
      return
      Container(
        padding: EdgeInsets.only(left: 5, top: 10, bottom: 0),
        child: 
        Text(title, style: TextStyle(
          color: Apptheme.textclrdark,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),)
      );
    } 

    );
  }
}