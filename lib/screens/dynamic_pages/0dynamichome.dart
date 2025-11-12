import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/manual_tab_2pages.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/widget_autosum.dart';



class Dynamichome extends StatefulWidget {
  final VoidCallback settingstogglee;
  const Dynamichome({super.key, required this.settingstogglee});


  @override
  State<Dynamichome> createState() => _DynamichomeState();
}

class _DynamichomeState extends State<Dynamichome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: 
          Column(
          children: [

            //--Custom Header for Home--
            PageHeaderTwo(title: "SPHERE", whathappens:widget.settingstogglee,),
            
            //--Main Page--
            Expanded(
              child: 
              Padding(padding: EdgeInsetsGeometry.only(top: 30, bottom: 20, left: 20, right: 20),
              child: 
              ManualTabpagesdoublepage(
                Tab1: "Your Products", 
                Tab1fontsize: 20, 
                Tab2: "Your Profiles", 
                Tab2fontsize: 20, 

                Pg1flexValue1: 1, 
                Pg1flexValue2: 2, 
                Pg2flexValue1: 1, 
                Pg2flexValue2: 1, 

                Firstchildof1:SizedBox(height: double.infinity,child:  Center(child: Text('Widget', style: TextStyle(color: Apptheme.textclrdark, fontSize: 20),))),

                Secondchildof1: SizedBox(
                  height: double.infinity,
                  child:  
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: 
                    ListView(
                      children: [
                        Center(child: 
                          Container(
                            width: double.infinity,
                            height: 330,
                            decoration: BoxDecoration(
                              color: Apptheme.widgetclrlight,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: 
                              [BoxShadow(
                                  color: Apptheme.header,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                )],
                              ),
                            child: 
                            Center(
                              child: Text('Insert Pie Charts here, by category', 
                                style: TextStyle(
                                  color: Apptheme.textclrdark, 
                                  fontSize: 20),
                                ),
                            ),
                          )
                        ),
//-------------------------------------------------------------------------------------------------------
                        Labels(title: 'Your Products',),

                        SizedBox(
                          width: double.infinity,
                          child: AutoaddWidget(
                            aspectratio: 16/5, 
                            color: Apptheme.widgetsecondaryclr, 
                            title: 'title'
                          ),
                        )
                      ],
                    ),
                  )
                ),

                Firstchildof2: SizedBox(height: double.infinity,
                child:  
                  Center(
                    child: 
                    Text('Widget', 
                    style: TextStyle(
                      color: Apptheme.textclrdark, 
                      fontSize: 20),
                    )
                  )
                ),

                Secondchildof2: SizedBox(height: double.infinity,
                child:  
                  Center(
                    child: 
                    Text('Widget', 
                    style: TextStyle(
                      color: Apptheme.textclrdark, 
                      fontSize: 20),
                    )
                  )
                ),
                
                )
              ),
            )
          ],
          ),
      );
  }
}