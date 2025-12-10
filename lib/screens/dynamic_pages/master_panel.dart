import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_app/riverpod.dart';




class MasterPanel extends ConsumerStatefulWidget {

  const MasterPanel({super.key, });


  @override
  ConsumerState<MasterPanel> createState() => _MasterPanelState();
}

class _MasterPanelState extends ConsumerState<MasterPanel> {

int selectedToggle = 0;

double pieChartSize = 240;
int touchedIndex = -1;

final List<String> toggleOptions = [
  'Scope',
  'Attributes',
  'Boundary'
];

String getPercentageTitle(double value, double total) {
  final percent = (value / total * 100).round();
  return '$percent%';
}


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
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: pieChartSize,
          title: 'Scope 2',
          radius: pieChartSize/2,
        ),
        PieChartSectionData(
          color: Apptheme.piechart3,
          value: 30,
          title: 'Scope 3',
          radius: pieChartSize/2,
        ),
      ],
      //--Sort by: Attributes--
      [
        PieChartSectionData(
          color: Apptheme.piechart1,
          value: emissions.material,
          title: 'Material Acqusition',
          radius: pieChartSize/2,
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: emissions.transport,
          title: 'Upstream Transport',
          radius: pieChartSize/2,
        ),
        PieChartSectionData(
          color: Apptheme.piechart3,
          value: emissions.machining,
          title: 'Machining',
          radius: pieChartSize/2,
        ),

      PieChartSectionData(
          color: Apptheme.piechart4,
          value: emissions.fugitive,
          title: 'Fugitive',
          radius: pieChartSize/2,
        ),
      ],
      //--Sort by: Boundaries--
      [
        PieChartSectionData(
          color: Apptheme.piechart1,
          value: 155,
          title: 'Upstream',
          radius: pieChartSize/2,
        ),
        PieChartSectionData(
          color: Apptheme.piechart2,
          value: 134,
          title: 'Production',
          radius: pieChartSize/2,
        ),

        PieChartSectionData(
          color: Apptheme.piechart3,
          value: 98,
          title: 'Downstream',
          radius: pieChartSize/2,
        ),
      ],
    ];
        
    List<PieChartSectionData> showingSections() {
      final data = pieDataSets[selectedToggle];
      final total = data.fold<double>(0, (sum, item) => sum + item.value);

      return List.generate(data.length, (i) {
        final section = data[i];
        final isTouched = i == touchedIndex;

        final double fontSize = isTouched ? 22 : 16;
        final double radius = isTouched ? (pieChartSize / 2 + 8) : (pieChartSize / 2);

        return section.copyWith(
          radius: radius,
          titleStyle:bodyTextlightmini(),
          title:  getPercentageTitle(section.value, total),
        );
      });
    }


    return ListView(
        children: [
                
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              decoration: BoxDecoration(
                color: Apptheme.widgetsecondaryclr,
                borderRadius: BorderRadius.circular(5)
              ),
              height: 50,
              width: 60,
              child: Row(
                children: [
                  Labels(
                    title: 'Sort by', 
                    color: Apptheme.textclrlight
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: selectedToggle,
                    dropdownColor: Apptheme.widgetsecondaryclr,
                    iconEnabledColor: Apptheme.textclrlight,
                    items: List.generate(toggleOptions.length, (index) {
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Labels(
                          title: toggleOptions[index], 
                          color: Apptheme.textclrlight
                        )
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
          ),
                          
          SizedBox(height: 0,),
                            
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(toggleTotals[selectedToggle].length, (i) {
              final key = toggleTotals[selectedToggle].keys.elementAt(i);
              final value = toggleTotals[selectedToggle].values.elementAt(i);
              final color = pieDataSets[selectedToggle][i].color; // match pie section color

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Textsinsidewidgets(
                      words: '$key emissions: ${value.toStringAsFixed(2)} kg CO2e', 
                      color: color
                    )
                  ],
                ),
              );
            }),
          ),
              
          SizedBox(height: 35,),
                            
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: pieChartSize,
              child: PieChart(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                PieChartData(
                  centerSpaceRadius: 0,
                  sectionsSpace: 0,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, response) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            response == null ||
                            response.touchedSection == null) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex =
                              response.touchedSection!.touchedSectionIndex;
                        }
                      });
                    },
                  ),
                  sections: showingSections(),
                ),
              ),
            ),
          ),

              
          Container(color: Apptheme.transparentcheat,height: 300,),  
          
        ],
      );

  }
}



         