import 'package:flutter/material.dart';

class Welcomepagelogo extends StatefulWidget {
  final VoidCallback? whathappens;
  final Color choosecolor;
  final double pad;
  final double size;

  const Welcomepagelogo({
    super.key,
    required this.whathappens,
    required this.choosecolor,
    this.pad = 8.0,
    this.size = 200
  });

  @override
  State<Welcomepagelogo> createState() => _WelcomepagelogoState();
}

class _WelcomepagelogoState extends State<Welcomepagelogo> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: widget.size),
                        child: AspectRatio(
                          aspectRatio: 1/1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: widget.size,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: widget.choosecolor,
                            ),
                            child: 
                                      
                            Center(child: Container(
                              padding: EdgeInsets.only(top: 0,bottom: 0),
                              alignment: Alignment.centerLeft,
                              child: 
                                SizedBox(
                                  width: double.infinity,
                                  child: 
                                  InkWell(
                                    onTap: widget.whathappens,
                                    child: Padding(
                                      padding: EdgeInsets.all(widget.pad),
                                      child: Image.asset('assets/images/LOGO Ver 1.png'),
                                    ))
                                ),
                              
                            ),
                            )
                          ),
                        ),
                      );

  }
}