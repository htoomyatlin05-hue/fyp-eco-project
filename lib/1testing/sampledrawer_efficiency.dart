import 'package:flutter/material.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/drawerlisttile.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/welcomelogo.dart';

class BackgroundDrawerfast extends StatelessWidget {
  final Function(int) onSelectPage;

  const BackgroundDrawerfast({super.key, required this.onSelectPage});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    // Fixed widths
    final double leftPanelWidth = 250;
    final double rightPanelWidth = 200;

    // Shortcut and bookmark items
    final List<Widget> shortcuts = [
      Leftdrawerlisttile(title: 'Products Analysis', whathappens: () => onSelectPage(1)),
      Leftdrawerlisttile(title: 'Organisational Analysis', whathappens: () => onSelectPage(1)),
      Leftdrawerlisttile(title: 'Boundary', whathappens: () => onSelectPage(2)),
      Leftdrawerlisttile(title: 'Datasets', whathappens: () => onSelectPage(3)),
    ];

    final List<Widget> bookmarks = [
      Leftdrawerlisttilelight(title: 'Sustainability News', whathappens: () => onSelectPage(4)),
      Leftdrawerlisttilelight(title: 'About Us', whathappens: () => onSelectPage(5)),
      Leftdrawerlisttilelight(title: 'Example1',),
      Leftdrawerlisttilelight(title: 'Example2',),
      Leftdrawerlisttilelight(title: 'Example3',),
      Leftdrawerlisttilelight(title: 'Example4',),
      Leftdrawerlisttilelight(title: 'Example5',),
      Leftdrawerlisttilelight(title: 'Example6',),
      Leftdrawerlisttilelight(title: 'Example7',),
    ];

    return Row(
      children: [
        //-- LEFT PANEL --
        Container(
          width: leftPanelWidth,
          height: screenHeight,
          color: Apptheme.transparentcheat,
          child: Column(
            children: [
              // 1. Header (fixed)
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Welcomepagelogo(
                    whathappens: () => onSelectPage(0),
                    choosecolor: Apptheme.transparentcheat,
                    pad: 0,
                  ),
                ),
              ),

              // 2. Shortcuts (fixed, non-scrollable)
              SizedBox(
                height: shortcuts.length * 48, // Adjust height per item
                child: Column(
                  children: shortcuts
                      .map((w) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: w,
                          ))
                      .toList(),
                ),
              ),

              // 3. Divider
              Divider(
                color: Apptheme.dividers,
                thickness: 2,
                indent: 35,
                endIndent: 35,
              ),

              // 4. Bookmarks (scrollable)
              Expanded(
                child: ListView.builder(
                  itemCount: bookmarks.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: bookmarks[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        //-- MAIN PAGE AREA (Fills remaining space minus right panel) --
        Expanded(
          child: Container(
            color: Apptheme.drawerbackground,
            child: Stack(
              children: [
                // Main content can go here if needed
              ],
            ),
          ),
        ),

        //-- RIGHT PANEL (Settings) --
        Container(
          width: rightPanelWidth,
          height: screenHeight,
          color: Apptheme.transparentcheat,
          child: Column(
            children: [
              // 1. Settings header (fixed)
              SizedBox(
                height: 80,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Apptheme.drawer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),

              // 2. Settings body (scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: List.generate(
                      10, // example dynamic content
                      (index) => Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Apptheme.drawer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 3. Logout button (fixed)
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Apptheme.drawer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/welcomepage'),
                    child: const Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
