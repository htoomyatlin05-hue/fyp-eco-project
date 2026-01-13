import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/riverpod_profileswitch.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';

class DynamicAllocation extends ConsumerStatefulWidget {
  const DynamicAllocation({super.key});

  @override
  ConsumerState<DynamicAllocation> createState() => _DynamicAllocationState();
}

class _DynamicAllocationState extends ConsumerState<DynamicAllocation> {
  final Set<String> selectedBasicParts = {};

Future<void> _showAddCompoundDialog() async {
  final selected = selectedBasicParts.toList();
  if (selected.isEmpty) return;

  final nameController = TextEditingController();

  final result = await showDialog<String>(
    context: context,
    useRootNavigator: true,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("New Compound Part"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Compound Name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext, rootNavigator: true).pop(null);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              Navigator.of(dialogContext, rootNavigator: true).pop(name);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );

  if (result == null || result.isEmpty) return;

  final product = ref.read(activeProductProvider);
  final timeline = ref.read(activeTimelineProvider);
  if (product == null || timeline == null) return;

  ref
      .read(compoundPartsProvider((product: product, timeline: timeline)).notifier)
      .addCompound(result, selected);

  selectedBasicParts.clear();
}


Future<void> _showAddHigherCompoundDialog() async {
  final product = ref.read(activeProductProvider);
  final timeline = ref.read(activeTimelineProvider);
  if (product == null || timeline == null) return;

  final compounds =
      ref.read(compoundPartsProvider((product: product, timeline: timeline))).compounds;

  if (compounds.isEmpty) return;

  final selected = <String>{};
  final nameController = TextEditingController();

  final result = await showDialog<String>(
    context: context,
    useRootNavigator: true,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (_, setState) {
          return AlertDialog(
            title: const Text("New Higher-Level Compound"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...compounds.map(
                    (c) => CheckboxListTile(
                      title: Text(c.name),
                      value: selected.contains(c.name),
                      onChanged: (v) {
                        setState(() {
                          if (v == true) {
                            selected.add(c.name);
                          } else {
                            selected.remove(c.name);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: "Compound Name"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext, rootNavigator: true).pop(null);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  Navigator.of(dialogContext, rootNavigator: true).pop(name);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    },
  );

  if (result == null || result.isEmpty || selected.isEmpty) return;

  ref
      .read(
        higherCompoundPartsProvider((product: product, timeline: timeline))
            .notifier,
      )
      .addHigherCompound(result, selected.toList());
}

  @override
  Widget build(BuildContext context) {
    final basicParts = ref.watch(partsProvider);

    final product = ref.watch(activeProductProvider);
    final timeline = ref.watch(activeTimelineProvider);

    final compoundParts = (product != null && timeline != null)
        ? ref.watch(
            compoundPartsProvider((product: product, timeline: timeline)),
          ).compounds
        : <CompoundPart>[];

    final higherCompounds = (product != null && timeline != null)
        ? ref.watch(
            higherCompoundPartsProvider((product: product, timeline: timeline)),
          ).compounds
        : <HigherCompoundPart>[];

    return PrimaryPages(
      childofmainpage: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            // ----------------- BASIC PARTS -----------------
            const Labels(
              title: "Basic Parts",
              color: Apptheme.textclrdark,
            ),

            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: basicParts.length,
                itemBuilder: (_, index) {
                  final part = basicParts[index];
                  final selected = selectedBasicParts.contains(part);

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      backgroundColor: Apptheme.widgettertiaryclr,
                      selectedColor: Apptheme.widgetsecondaryclr,
                      label: Container(
                        height: 25,
                        color: Apptheme.transparentcheat,
                        child: Textsinsidewidgetsdrysafe(
                          words: part,
                          color: Apptheme.textclrdark,
                          toppadding: 0,
                        ),
                      ),
                      selected: selected,
                      onSelected: (v) {
                        setState(() {
                          v
                              ? selectedBasicParts.add(part)
                              : selectedBasicParts.remove(part);
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Apptheme.widgettertiaryclr,
                foregroundColor: Apptheme.widgetclrdark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
              ),
              onPressed: _showAddCompoundDialog,
              child: SizedBox(
                width: 180,
                child: const Textsinsidewidgets(
                  words: "Create Compound Part",
                  color: Apptheme.textclrdark,
                  toppadding: 0,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ----------------- COMPOUND PARTS -----------------
            const Labels(
              title: "Compound Parts",
              color: Apptheme.textclrdark,
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: compoundParts.length,
              itemBuilder: (_, index) {
                final c = compoundParts[index];
                return ListTile(
                  contentPadding: const EdgeInsets.only(bottom: 5, left: 17),
                  title: Textsinsidewidgetsdrysafe(
                    words: c.name,
                    color: Apptheme.textclrdark,
                    fontsize: 17,
                    toppadding: 0,
                  ),
                  subtitle: Textsinsidewidgetsdrysafe(
                    words: c.components.join(", "),
                    color: Apptheme.textclrdark,
                    fontsize: 13,
                    toppadding: 5,
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Apptheme.widgettertiaryclr,
                foregroundColor: Apptheme.widgetclrdark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5),
                ),
              ),
              onPressed: _showAddHigherCompoundDialog,
              child: SizedBox(
                width: 225,
                child: const Textsinsidewidgetsdrysafe(
                  words: "Add Higher-Level Compound",
                  color: Apptheme.textclrdark,
                  toppadding: 0,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ----------------- HIGHER LEVEL -----------------
            if (higherCompounds.isNotEmpty) ...[
              const Labels(
                title: "Higher-Level Compounds",
                color: Apptheme.textclrdark,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: higherCompounds.length,
                itemBuilder: (_, index) {
                  final c = higherCompounds[index];
                  return ListTile(
                    title: Textsinsidewidgetsdrysafe(
                      words: c.name,
                      color: Apptheme.textclrdark,
                      fontsize: 17,
                      toppadding: 0,
                    ),
                    subtitle: Textsinsidewidgetsdrysafe(
                      words: c.components.join(", "),
                      color: Apptheme.textclrdark,
                      fontsize: 13,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
