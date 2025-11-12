import 'package:flutter/material.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/widgets1.dart';
      
class SlidingRowwidget extends StatelessWidget {
  final double aspectratio;
  final Color color;
  const SlidingRowwidget({super.key, 
  required this.aspectratio, 
  required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Widgets1(
      maxheight: 88,
        aspectratio: aspectratio,
        child: Padding(padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Widgets2(aspectratio: 1/1, color: color,
                  child: Center(child: Text('Product 1'),))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Widgets2(aspectratio: 1/1, color: color,
                  child: Center(child: Text('Product 2'),))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Widgets2(aspectratio: 1/1, color: color,
                  child: Center(child: Text('Product 3'),))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Widgets2(aspectratio: 1/1, color: color,
                  child: Center(child: Text('Product 4'),))),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 10),child: Widgets2(aspectratio: 1/1, color: color,
                  child: Center(child: Text('Product 5'),))),
                  
                ],
              ),
            ),
          ),
        ),
      );
  }
}