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
  // PARTS + VALUES FOR PIE CHART
  final List<String> parts = [];
  final List<double> partValues = [];

  // DATES + VALUES FOR LINE CHART
  final List<String> dates = [];
  final List<double> dateValues = [];

  /// ---------- Reusable input dialog ----------
  Future<Map<String, String>?> _showInputDialog({
    required String title,
    required Map<String, TextInputType> fields,
  }) async {
    final controllers = {
      for (var key in fields.keys) key: TextEditingController(),
    };

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
                for (var entry in controllers.entries)
                  entry.key: entry.value.text.trim(),
              };
              Navigator.of(dialogContext).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (result.values.any((v) => v.isNotEmpty)) {
      return result;
    }
    return null;
  }

  /// ---------- Add Part (for pie chart) ----------
  Future<void> _addPart() async {
    final res = await _showInputDialog(
      title: "Add Part",
      fields: {
        "Part Name": TextInputType.text,
        "Value": TextInputType.number,
      },
    );

    if (res != null &&
        res["Part Name"]!.isNotEmpty &&
        res["Value"]!.isNotEmpty) {
      setState(() {
        parts.add(res["Part Name"]!);
        partValues.add(double.tryParse(res["Value"]!) ?? 0);
      });
    }
  }

  /// ---------- Add Date (for line chart) ----------
  Future<void> _addDate() async {
    final res = await _showInputDialog(
      title: "Add Date Value",
      fields: {
        "Year": TextInputType.number,
        "Month (1–12)": TextInputType.number,
        "Value": TextInputType.number,
      },
    );

    if (res != null &&
        res["Year"]!.isNotEmpty &&
        res["Month (1–12)"]!.isNotEmpty &&
        res["Value"]!.isNotEmpty) {
      setState(() {
        dates.add("${res["Month (1–12)"]}/${res["Year"]}");
        dateValues.add(double.tryParse(res["Value"]!) ?? 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build line chart spots
    final lineSpots = List.generate(
      dateValues.length,
      (i) => FlSpot(i.toDouble(), dateValues[i]),
    );

    // Build pie chart sections
    final pieSections = List.generate(parts.length, (i) {
      return PieChartSectionData(
        value: partValues[i],
        title: parts[i],
      );
    });

    return PrimaryPages(
      backgroundcolor: Apptheme.widgetclrlight,
      childofmainpage: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // -------- PARTS ----------
            Row(
              children: [
                const Text("Parts (Pie Chart)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(onPressed: _addPart, icon: const Icon(Icons.add)),
              ],
            ),

            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: parts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) =>
                    Chip(label: Text("${parts[index]} = ${partValues[index]}")),
              ),
            ),

            const SizedBox(height: 12),

            // -------- PIE CHART ----------
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: pieSections,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // -------- DATES ----------
            Row(
              children: [
                const Text("Dates (Line Chart)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(onPressed: _addDate, icon: const Icon(Icons.add)),
              ],
            ),

            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) => Chip(
                    label: Text("${dates[index]} = ${dateValues[index]}")),
              ),
            ),

            const SizedBox(height: 12),

            // -------- LINE CHART ----------
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
                          if (idx < 0 || idx >= dates.length) {
                            return const SizedBox();
                          }
                          return Text(
                            dates[idx],
                            style: const TextStyle(fontSize: 8),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: lineSpots,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
