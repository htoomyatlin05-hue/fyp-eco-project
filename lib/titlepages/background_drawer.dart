import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/buttons_and_icons.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/hover_drawer.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/welcomelogo.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/sub_drawer.dart';
import 'package:test_app/screens/dynamic_pages/master_panel.dart';

class BackgroundDrawer extends ConsumerStatefulWidget {
  final Function(int) onSelectPage;

  const BackgroundDrawer({super.key, required this.onSelectPage});

    @override
  ConsumerState<BackgroundDrawer> createState() => _BackgroundDrawerState();
}

class _BackgroundDrawerState extends ConsumerState<BackgroundDrawer> {

  double getShortcutCountAsDouble(List<Widget> shortcuts) => shortcuts.length.toDouble();
  double getBookmarkCountAsDouble(List<Widget> bookmarks) => bookmarks.length.toDouble();
  

  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;

    double getShortcutCountAsDouble(List<Widget> shortcuts) => shortcuts.length.toDouble();

    final List<Widget> shortcuts=[
                          

      Leftdrawerlisttile(
          title: 'Attributes', 
          whathappens: () => widget.onSelectPage(1)),
    
      Leftdrawerlisttile(
          title: 'Allocation', 
          whathappens: () => widget.onSelectPage(2)),

      Leftdrawerlisttile(
        title: 'Sustainability News', 
        whathappens: () => widget.onSelectPage(3)),

      Leftdrawerlisttile(
        title: 'About Us', 
        whathappens: () => widget.onSelectPage(4)),

      Leftdrawerlisttile(
        title: 'Debug Page', 
        whathappens: () => widget.onSelectPage(5)),
                  
    ];

    final List<Widget> bookmarks=[
     
                  

      Leftdrawerlisttilelight(
          title: 'Category 1 ', 
          whathappens: () => widget.onSelectPage(6)),
                  
      Leftdrawerlisttilelight(
          title: 'Category 2', 
          whathappens: () => widget.onSelectPage(7)),
                  
      Leftdrawerlisttilelight(
          title: 'Category 3', 
          whathappens: () => widget.onSelectPage(8)),

      Leftdrawerlisttilelight(
          title: 'Category 4', 
          whathappens: () => widget.onSelectPage(9)),

      Leftdrawerlisttilelight(
          title: 'Category 5', 
          whathappens: () => widget.onSelectPage(10)),
      
      Leftdrawerlisttilelight(
          title: 'Category 9', 
          whathappens: () => widget.onSelectPage(11)),
      
      Leftdrawerlisttilelight(
          title: 'Category 10', 
          whathappens: () => widget.onSelectPage(12)),
                
      Leftdrawerlisttilelight(
          title: 'Category 11', 
          whathappens: () => widget.onSelectPage(13)),
                
      Leftdrawerlisttilelight(
          title: 'Category 12', 
          whathappens: () => widget.onSelectPage(14)),

    ];

    final double shotcutsno = getShortcutCountAsDouble(shortcuts);

    return Stack(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            //--Header & List of Pages--
            Container(
                color: Apptheme.transparentcheat,
                height: screenHeight,
                width: 280,
                child: 
                Column(
                  children: [
                                
                    Padding(padding: EdgeInsetsGeometry.all(8),
                      child: 
                      Container(
                        alignment: Alignment.center,
                        height: 100-(2*8),
                        decoration: BoxDecoration(
                          color: Apptheme.transparentcheat,
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20,),
                            Welcomepagelogo(
                              whathappens: () => widget.onSelectPage(0), 
                              choosecolor: Apptheme.transparentcheat, 
                              pad: 0,
                              size: 70,
                            ),
                            const SizedBox(width: 10,),
                            Bigfocusedtext(
                              title: 'ECO-pi',
                              fontsize: 40,
                            )
                          ],
                        ),
                      )
                    ),

                    Padding(padding: EdgeInsetsGeometry.only(left: 60),
                    child: MasterPanel(),
                    )

                  ],
                ),
              ),
                  
            
            //--Settings--
            Container(
              padding: EdgeInsets.only(top: 25, bottom: 12),
              width:  200,
              decoration: BoxDecoration(color: Apptheme.transparentcheat),
              child: 
            
              //--THE LIST IS HERE--
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            
                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    double parentWidth = constraints.maxWidth;
            
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: 
                      Container(
                        alignment: Alignment.center,
                        width: parentWidth/1.1,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Apptheme.drawer,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                        Text('Settings',
                          style: TextStyle(
                            color: Apptheme.textclrlight,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.fade,
                            fontSize: 25
                          ),
                          maxLines: 1,
                          softWrap: false,
                          textAlign: TextAlign.center,                 
                        ),
                      ),
                    );
                  },),
            
                  Expanded(
                    child:
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: 
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Apptheme.dividers,
                          )
                        ),
                      ),
                    )
                  ),
            
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: 
                    Container(
                      decoration: BoxDecoration(
                        color: Apptheme.drawer,
                        borderRadius: BorderRadius.circular(10)
                        ),
                      height: 35,
                      width: double.infinity,
                      child: 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          TextButton(onPressed:   () => Navigator.pushNamed(context, '/welcomepage'),
                          child:
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Center(
                                child: Text('Logout', 
                                  style: TextStyle(
                                  fontSize: 20,
                                  color: Apptheme.textclrlight,
                                  ),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                ),
                              ),
                            ),
                          ),
                                  
                          Loggingout(),
                                              
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                
            )
        
          ]
        ),
      
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: HoverSidebarWithNested(onSelectPage: widget.onSelectPage,),
          )
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: LShapeContainer(
            verticalWidth: 60, 
            horizontalHeight: 20
          )
        )
      
      ],
    );
      
  }
}


class Leftdrawerlisttile extends StatelessWidget {
  final String title;
  final VoidCallback? whathappens;

  const Leftdrawerlisttile({
    super.key,
    required this.title,
    this.whathappens = empty,
  });

  static void empty() {}
  
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
    super.key,
    required this.title,
    this.whathappens = empty,
  });

  static void empty() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 80),
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
