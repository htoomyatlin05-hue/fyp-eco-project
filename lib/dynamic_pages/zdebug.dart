import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/riverpod.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';

class DebugPage extends ConsumerWidget {
  const DebugPage({super.key});

  static const Map<String, List<String>> tables = {
    "Material Acquisition": [
      "Country",
      "Material",
      "Mass (kg)",
    ],
    "Upstream Transport": [
      "Country",
      "Material",
      "Mass (kg)",
    ],
    "Machining": [
      "Country",
      "Material",
      "Mass (kg)",
    ],
    "Fugitive": [
      "Country",
      "Material",
      "Mass (kg)",
    ],
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryPages(
      childofmainpage: ListView(
        scrollDirection: Axis.vertical,
        children: [
          for (final entry in tables.entries) ...[
            Builder(
              builder: (context) {
                final columns = entry.value.length;
                final tableState =
                    ref.watch(tableControllerProvider(columns));
                final selections = tableState.selections;

                final rowCount =
                    selections.isNotEmpty ? selections[0].length : 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Labels(
                      title:
                          "${entry.key} Debug Summary ($rowCount row${rowCount == 1 ? '' : 's'})",
                      color: Apptheme.textclrdark,
                    ),

                    const SizedBox(height: 8),

                    if (rowCount == 0)
                      Textsinsidewidgets(
                        words: "No rows added.",
                        color: Apptheme.textclrdark,
                      ),

                    for (int row = 0; row < rowCount; row++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Textsinsidewidgets(
                          words:
                              "Row ${row + 1}: ${List.generate(columns, (col) {
                            final value = selections[col][row];
                            return "${entry.value[col]} = "
                                "${value?.isNotEmpty == true ? value : '—'}";
                          }).join(" | ")}",
                          color: Apptheme.textclrdark,
                        ),
                      ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

