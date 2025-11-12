import 'package:flutter/material.dart';

class Welcomepagelogo extends StatefulWidget {
  final VoidCallback? whathappens;
  final Color choosecolor;
  final double pad;
  const Welcomepagelogo({
    Key? key,
    required this.whathappens,
    required this.choosecolor,
    this.pad = 8.0,
  }) : super(key: key);

  @override
  State<Welcomepagelogo> createState() => _WelcomepagelogoState();
}

class _WelcomepagelogoState extends State<Welcomepagelogo> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: AspectRatio(
                          aspectRatio: 1/1,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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