import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/apptheme/textlayout.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test_app/riverpod.dart';
import 'package:test_app/riverpod_profileswitch.dart';

class Dynamichome extends ConsumerStatefulWidget {
  final String? productName;
  const Dynamichome({super.key, this.productName});

  @override
  ConsumerState<Dynamichome> createState() => _DynamichomeState();
}

class _DynamichomeState extends ConsumerState<Dynamichome> {
  // ------------------------------------------------------------
  // INIT: set active product ONCE (safe)
  // ------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeProductProvider.notifier).state = widget.productName;
    });
  }

  /// ---------- Reusable input dialog ----------
  Future<Map<String, String>?> _showInputDialog({
    required BuildContext context,
    required String title,
    required Map<String, TextInputType> fields,
  }) async {
    final controllers = {for (var key in fields.keys) key: TextEditingController()};
    Map<String, String> result = {};

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: fields.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextField(
                  controller: controllers[e.key],
                  keyboardType: e.value,
                  decoration: InputDecoration(labelText: e.key),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              result = {
                for (var entry in controllers.entries) entry.key: entry.value.text.trim()
              };
              Navigator.of(dialogContext).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    return result.values.any((v) => v.isNotEmpty) ? result : null;
  }

  /// ---------- Add Part (Pie Chart) ----------
  Future<void> _addPart(BuildContext context) async {
    final product = ref.read(activeProductProvider);
    final timeline = ref.read(activeTimelineProvider);

    if (product == null || timeline == null) return;

    final res = await _showInputDialog(
      context: context,
      title: "Add Part",
      fields: {
        "Part Name": TextInputType.text,
        "Value": TextInputType.number,
      },
    );

    if (res == null) return;

    final partName = res["Part Name"]!;
    final value = double.tryParse(res["Value"]!);

    if (partName.isEmpty || value == null) return;

    ref.read(pieChartProvider((product: product, timeline: timeline)).notifier).addPart(partName, value);
  }

  /// ---------- Add Date (Line Chart + Timeline) ----------
  Future<void> _addDate(BuildContext context) async {
    final product = ref.read(activeProductProvider);
    if (product == null) return;

    final res = await _showInputDialog(
      context: context,
      title: "Add Date Value",
      fields: {
        "Year": TextInputType.number,
        "Month (1–12)": TextInputType.number,
        "Value": TextInputType.number,
      },
    );

    if (res == null) return;

    final year = res["Year"]!;
    final month = res["Month (1–12)"]!;
    final value = double.tryParse(res["Value"]!);

    if (year.isEmpty || month.isEmpty || value == null) return;

    final timeline = "$month/$year";

    ref.read(timelineProvider(product).notifier).addTimeline(timeline);
    ref.read(lineChartProvider(product).notifier).addDate(timeline, value);
    ref.read(activeTimelineProvider.notifier).state = timeline;
  }

  // ------------------------------------------------------------
  // BUILD (READ ONLY)
  // ------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    ref.watch(productTimelineResetProvider);

    final product = ref.watch(activeProductProvider);
    final activeTimeline = ref.watch(activeTimelineProvider);

    final lineChart = product == null ? null : ref.watch(lineChartProvider(product));

    final pieChart = (product != null && activeTimeline != null)
        ? ref.watch(pieChartProvider((product: product, timeline: activeTimeline)))
        : null;

    // Pie chart sections
    final pieSections = pieChart == null
        ? <PieChartSectionData>[]
        : List.generate(
            pieChart.parts.length,
            (i) => PieChartSectionData(
              value: pieChart.values[i],
              title: pieChart.parts[i],
            ),
          );

    // Line chart spots
    final lineSpots = lineChart == null
        ? <FlSpot>[]
        : List.generate(
            lineChart.values.length,
            (i) => FlSpot(i.toDouble(), lineChart.values[i]),
          );

    // ------------------------------------------------------------
    // UI
    // ------------------------------------------------------------
    return PrimaryPages(
      backgroundcolor: Apptheme.widgetclrlight,
      childofmainpage: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // -------- LINE CHART ----------
            Row(
              children: [
                const Labels(
                  title: 'Timeline of Product (WORK IN PROGRESS)',
                  color: Apptheme.textclrdark,
                ),
                const Spacer(),
                IconButton(onPressed: () => _addDate(context), icon: const Icon(Icons.add)),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: lineChart?.dates.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => ChoiceChip(
                  label: Text(lineChart!.dates[index]),
                  selected: lineChart.dates[index] == activeTimeline,
                  onSelected: (_) {
                    ref.read(activeTimelineProvider.notifier).state = lineChart.dates[index];
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (lineChart == null || idx < 0 || idx >= lineChart.dates.length) return const SizedBox();
                          return Text(lineChart.dates[idx], style: const TextStyle(fontSize: 8));
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [LineChartBarData(isCurved: true, spots: lineSpots)],
                ),
              ),
            ),

            // -------- PIE CHART ----------
            Row(
              children: [
                const Labels(
                  title: "Parts Assembly (UNFINISHED)",
                  color: Apptheme.textclrdark,
                ),
                const Spacer(),
                IconButton(onPressed: () => _addPart(context), icon: const Icon(Icons.add)),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: pieChart?.parts.length ?? 0,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => Chip(
                  label: Text("${pieChart!.parts[index]} = ${pieChart.values[index]}"),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: PieChart(PieChartData(sections: pieSections)),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
