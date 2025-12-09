import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/app_design.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/widget_autosum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_app/design/secondary_elements_(to_design_pages)/widgets.dart';
import 'package:test_app/riverpod.dart';




class MasterPanel extends ConsumerStatefulWidget {

  const MasterPanel({super.key, });


  @override
  ConsumerState<MasterPanel> createState() => _MasterPanelState();
}

class _MasterPanelState extends ConsumerState<MasterPanel> {

int selectedToggle = 0;

double pieChartSize = 150;

final List<String> toggleOptions = [
  'Scope',
  'Attributes',
  'Boundary'
];


  @override
  Widget build(BuildContext context) {
    final emissions = ref.watch(emissionCalculatorProvider);

    final List<Map<String, double>> toggleTotals = [
      // Scope Categories
      {
        'Scope 1': 60,
        'Scope 2': 40,
        'Scope 3': 30,
      },
      // LCA Categories
      {
        'Material': emissions.material,
        'Transport': emissions.transport,
        'Machining': emissions.machining,
        'Fugitive': emissions.fugitive,
      },
      // Boundary
      {
        'Upstream': 155,
        'Production': 134,
        'Downstream': 98,
      },
    ];


    final List<List<PieChartSectionData>> pieDataSets = [
      //--Sort by: Scope Categories--
      [
        PieChartSectionData(
          color: Apptheme.piechart1,
          value: 60,
          title: 'Scope 1',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: pieChartSize,
          title: 'Scope 2',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
        PieChartSectionData(
          color: Apptheme.piechart3,
          value: 30,
          title: 'Scope 3',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
      ],
      //--Sort by: Attributes--
      [
        PieChartSectionData(
          color: Apptheme.piechart1,
          value: emissions.material,
          title: 'Material Acqusition',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: emissions.transport,
          title: 'Upstream Transport',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
        PieChartSectionData(
          color: Apptheme.piechart3,
          value: emissions.machining,
          title: 'Machining',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),

      PieChartSectionData(
          color: Apptheme.piechart4,
          value: emissions.fugitive,
          title: 'Fugitive',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
      ],
      //--Sort by: Boundaries--
      [
        PieChartSectionData(
          color: Apptheme.piechart1,
          value: 155,
          title: 'Upstream',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: 134,
          title: 'Production',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),

        PieChartSectionData(
          color: Apptheme.piechart3,
          value: 98,
          title: 'Downstream',
          radius: pieChartSize/2,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Apptheme.textclrdark,
          ),
        ),
      ],
    ];
        
    return Column(
        children: [

          SizedBox(
            height: 40,
          ),
                
          Center(child: 
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Apptheme.transparentcheat,
                  borderRadius: BorderRadius.circular(15),
                  
                  ),
                child: 
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      color: Apptheme.transparentcheat,
                      constraints: BoxConstraints(
                        minHeight: 0,
                      ),
                      child: 
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Sort by: ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Apptheme.textclrlight,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                DropdownButton<int>(
                                  value: selectedToggle,
                                  dropdownColor: Apptheme.widgetsecondaryclr,
                                  iconEnabledColor: Apptheme.textclrlight,
                                  items: List.generate(toggleOptions.length, (index) {
                                    return DropdownMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        toggleOptions[index],
                                        style: TextStyle(
                                          color: Apptheme.textclrlight,
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }),
                                  onChanged: (int? newIndex) {
                                    if (newIndex != null) {
                                      setState(() {
                                        selectedToggle = newIndex;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),


                    
                          SizedBox(height: 20,),
                    
                          for (int i = 0; i < toggleTotals[selectedToggle].length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Textsinsidewidgets(
                                  words:
                                      '${toggleTotals[selectedToggle].keys.elementAt(i)} emissions: ${toggleTotals[selectedToggle].values.elementAt(i).toStringAsFixed(2)} kg CO2e',
                                  color: Apptheme.textclrlight,
                                  fontsize: 16,
                                ),
                              ),
                            ),
                    
                          Expanded(
                            child: SizedBox(
                              height: pieChartSize/1,
                              child: PieChart(duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                                PieChartData(
                                  centerSpaceRadius: 0,
                                  sections:
                                    pieDataSets[selectedToggle],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ),  
          
        ],
      );

  }
}



         