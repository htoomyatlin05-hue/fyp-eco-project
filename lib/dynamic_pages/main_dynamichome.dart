import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/design/apptheme/colors.dart';
import 'package:test_app/design/primary_elements(to_set_up_pages)/pages_layouts.dart';
import 'package:fl_chart/fl_chart.dart';

class Dynamichome extends ConsumerStatefulWidget {
  const Dynamichome({super.key});

  @override
  ConsumerState<Dynamichome> createState() => _DynamichomeState();
}

class _DynamichomeState extends ConsumerState<Dynamichome> {
  final List<String> parts = [];
  final List<String> dates = [];

  /// ---------- Reusable input dialog ----------
Future<Map<String, String>?> _showInputDialog({
  required String title,
  required Map<String, TextInputType> fields,
}) async {
  final controllers = {
    for (var key in fields.keys) key: TextEditingController(),
  };

  // Start with an empty map, will fill if user clicks OK
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
          onPressed: () => Navigator.of(dialogContext).pop(), // Close dialog
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            // Fill the result map
            result = {
              for (var entry in controllers.entries) entry.key: entry.value.text.trim(),
            };
            Navigator.of(dialogContext).pop(); // Close dialog
          },
          child: const Text("OK"),
        ),
      ],
    ),
  );

  // If all values are empty, return null
  if (result.values.any((v) => v.isNotEmpty)) {
    return result;
  }
  return null;
}


  /// ---------- Add a new part ----------
  Future<void> _addPart() async {
    final res = await _showInputDialog(
      title: "Add Part",
      fields: {"Part Name": TextInputType.text},
    );

    if (res != null && res["Part Name"]!.isNotEmpty) {
      if (!mounted) return;
      setState(() => parts.add(res["Part Name"]!));
    }
  }

  /// ---------- Add a new date ----------
  Future<void> _addDate() async {
    final res = await _showInputDialog(
      title: "Add Date",
      fields: {
        "Year": TextInputType.number,
        "Month (1–12)": TextInputType.number,
      },
    );

    if (res != null &&
        res["Year"]!.isNotEmpty &&
        res["Month (1–12)"]!.isNotEmpty) {
      if (!mounted) return;
      setState(() => dates.add("${res["Month (1–12)"]}/${res["Year"]}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryPages(
      backgroundcolor: Apptheme.widgetclrlight,
      childofmainpage: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // -------- PARTS LIST ----------
            Row(
              children: [
                const Text("Parts", style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.add), onPressed: _addPart),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: parts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => Chip(label: Text(parts[index])),
              ),
            ),
            const SizedBox(height: 16),

            // -------- LINE CHART ----------
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: const [
                        FlSpot(0, 2),
                        FlSpot(1, 3),
                        FlSpot(2, 1.5),
                        FlSpot(3, 4),
                        FlSpot(4, 3.5),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // -------- PIE CHART ----------
            SizedBox(
              height: 160,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 40, title: "A"),
                    PieChartSectionData(value: 30, title: "B"),
                    PieChartSectionData(value: 30, title: "C"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // -------- DATES LIST ----------
            Row(
              children: [
                const Text("Dates", style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.add), onPressed: _addDate),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => Chip(label: Text(dates[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
