import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/drawerlisttile.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/welcomelogo.dart';

class BackgroundDrawersample extends StatelessWidget {
  final Function(int) onSelectPage;


  const BackgroundDrawersample({super.key, required this.onSelectPage});

  @override
Widget build(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);
  final screenWidth = mediaQueryData.size.width;

  final List<Widget> shortcuts=[
      Leftdrawerlisttile(
          title: 'Profile Analysis', 
          whathappens: () => onSelectPage(1)),
      
       Leftdrawerlisttile(
          title: 'Boundary', 
          whathappens: () => onSelectPage(2)),

    
      Leftdrawerlisttile(
          title: 'Datasets', 
          whathappens: () => onSelectPage(3))

    ];

  return LayoutBuilder(
    builder: (context, constraints) {
      double height = constraints.maxHeight;

      // Responsive breakpoints
      bool showSecondList = height > 600;
      bool showFooter = height > 500;
      bool showMainList = height > 300;
      bool showHeader = height > 250;

      return SizedBox(
        width: screenWidth,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: double.infinity,
              width: screenWidth * (1 / 4),
              color: Apptheme.drawerbackground,
              child: Column(
                children: [
                  //-- HEADER --
                  AnimatedOpacity(
                    opacity: showHeader ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showHeader,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Welcomepagelogo(
                          whathappens: () => onSelectPage(0),
                          choosecolor: Apptheme.transparentcheat,
                          pad: 0,
                        ),
                      ),
                    ),
                  ),

                  AnimatedOpacity(
                    opacity: showHeader ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showHeader,
                      child: Divider(
                        color: Apptheme.dividers,
                        thickness: 2,
                        indent: 60,
                        endIndent: 60,
                      ),
                    ),
                  ),

                  //-- MAIN LIST --
                  AnimatedOpacity(
                    opacity: showMainList ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showMainList,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shortcuts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: shortcuts[index],
                        ),
                      ),
                    ),
                  ),

                  AnimatedOpacity(
                    opacity: showMainList ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showMainList,
                      child: Divider(
                        color: Apptheme.dividers,
                        thickness: 2,
                        indent: 35,
                        endIndent: 35,
                      ),
                    ),
                  ),

                  //-- SECONDARY LIST --
                  AnimatedOpacity(
                    opacity: showSecondList ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showSecondList,
                      child: Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 8),
                          child: ListView(
                            children: [
                              _drawerLightTile('Sustainability News', 4),
                              _drawerLightTile('About Us', 5),
                              _drawerLightTile('Example1', null),
                              _drawerLightTile('Example2', null),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //-- FOOTER --
                  AnimatedOpacity(
                    opacity: showFooter ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: showFooter,
                      child: Column(
                        children: [
                          Divider(
                            color: Apptheme.dividers,
                            thickness: 2,
                            indent: 35,
                            endIndent: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: _buildFooter(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //-- SETTINGS SIDE PANEL --
            Container(
              height: double.infinity,
              width: screenWidth * (0.2 / 4),
              color: Apptheme.drawerbackground,
              child: Center(
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.drag_indicator),
                  iconSize: 35,
                  color: Apptheme.iconsprimary,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

//--- Helper widgets ---
Widget _drawerLightTile(String title, int? pageIndex) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Leftdrawerlisttilelight(
        title: title,
        whathappens: pageIndex != null ? () => onSelectPage(pageIndex) : null,
      ),
    );

Widget _buildFooter(BuildContext context) => Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Apptheme.drawer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/welcomepage'),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
}

