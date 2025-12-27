import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';
import 'package:test_app/riverpod.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(materialTableProvider);
    final tableNotifier = ref.read(materialTableProvider.notifier);

    final rowCount = tableState.materials.length;

    return PrimaryPages(
      childofmainpage: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Labels(
            title: "Material Acquisition Debug Table ($rowCount row${rowCount == 1 ? '' : 's'})",
            color: Apptheme.textclrdark,
          ),
          const SizedBox(height: 16),

          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FixedColumnWidth(120),
              2: FixedColumnWidth(120),
              3: FlexColumnWidth(),
              4: FixedColumnWidth(70),
            },
          
            children: [
              /// ---------- HEADER ----------
              TableRow(
                decoration: BoxDecoration(
                  color: Apptheme.widgetsecondaryclr.withOpacity(0.1),
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Material", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Country", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Mass (kg)", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Allocation Value", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("Action", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              
          
              /// ---------- ROWS ----------
              for (int index = 0; index < rowCount; index++)
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0),
                      child: Textsinsidewidgets(
                        words:tableState.materials[index] ?? '—',
                        color: Apptheme.textclrdark,
                        fontsize: 15,
                        toppadding: 0,
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:0),
                      child: Textsinsidewidgets(
                        words: tableState.countries[index] ?? '—', 
                        color: Apptheme.textclrdark,
                        fontsize: 15,
                        toppadding: 0,
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:0),
                      child: Textsinsidewidgets(
                        words: tableState.masses[index] ?? '—',
                        color: Apptheme.textclrdark,
                        fontsize: 15,
                        toppadding: 0,
                        ),
                    ),
          
                    /// EDITABLE TEXTFIELD (SAFE)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: TextField(
                        controller: TextEditingController(
                          text: tableState.allocationValues[index] ?? '',
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: '1.00 kg',
                          hintStyle: TextStyle(
                            fontSize: 15, 
                            color: Apptheme.texthintclrdark,
                          )
                        ),
                        onChanged: (value) {
                          tableNotifier.updateCell(
                            row: index,
                            column: 'Allocation Value',
                            value: value,
                          );
                        },
                      ),
                    ),
          
                    /// CHECK ICON (no action yet)
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.check_circle_outline,
                        color: Apptheme.iconsprimary,
                        size: 18,
                        ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              List<RowFormat> rows = List.generate(
                tableState.materials.length,
                (i) => RowFormat(
                  columnTitles: ['Material', 'Country', 'Mass (kg)'],
                  isTextFieldColumn: [false, false, true],
                  selections: [
                    tableState.materials[i],
                    tableState.countries[i],
                    tableState.masses[i],
                  ],
                ),
              );

              await ref
                  .read(emissionCalculatorProvider.notifier)
                  .calculate('material', rows);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Apptheme.widgetsecondaryclr,
            ),
            child: const Labelsinbuttons(
              title: "Calculate Emissions",
              color: Apptheme.textclrlight,
              fontsize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
