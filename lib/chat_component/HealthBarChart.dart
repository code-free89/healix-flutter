import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // To handle JSON parsing

class Healthbarchart extends StatefulWidget {
  const Healthbarchart({super.key});

  @override
  State<Healthbarchart> createState() => _HealthbarchartState();
}

class _HealthbarchartState extends State<Healthbarchart> {
  String selectedDataType = 'STEPS'; // Default to STEPS
  Map<String, dynamic> healthData =
      {}; // Empty map to store dynamic health data

  @override
  void initState() {
    super.initState();
    fetchHealthData();
  }

  // Simulating API response parsing
  void fetchHealthData() {
    // Example API response (replace with actual response)
    String apiResponse = '''
    {
        "id": "fBa4A8pJ4IYqbxBgbrAzdbmhI2k1",
        "matching_items": [
            {
                "date_from": "2024-10-10T09:40:00.000",
                "value": {
                    "__type": "NumericHealthValue",
                    "numeric_value": {
                        "__type": "NumericHealthValue",
                        "numeric_value": 100.0
                    }
                },
                "source_name": "Health",
                "source_device_id": "F903AF56-237A-4558-870B-14118248C0FE",
                "type": "STEPS",
                "unit": "COUNT",
                "date_to": "2024-10-10T09:40:00.000",
                "source_id": "com.apple.Health",
                "is_manual_entry": true,
                "source_platform": "Health"
            }
        ]
    }
    ''';

    Map<String, dynamic> parsedResponse = jsonDecode(apiResponse);
    List<dynamic> matchingItems = parsedResponse['matching_items'];

    List<Map<String, dynamic>> values = [];

    // Extract the values from the response
    for (var item in matchingItems) {
      String dateFrom = item['date_from'];
      double numericValue = item['value']['numeric_value']['numeric_value'];

      // Add the data to the list
      values.add({
        dateFrom: {"numeric_value": numericValue.toString()}
      });
    }

    setState(() {
      // Dynamically updating healthData for STEPS
      healthData['STEPS'] = {
        "unit": "COUNT",
        "values": values,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: gray5Color, //Code for Answer Chat View
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(12),
            )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: healthData.isNotEmpty
                  ? BarChart(
                      BarChartData(
                        maxY: getMaxYValue(),
                        alignment: BarChartAlignment.spaceAround,
                        barGroups: getBarGroups(),
                        barTouchData: BarTouchData(
                            enabled: false), // Disable touch interaction
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false, // Hide vertical grid lines
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: gray1Color,
                            strokeWidth: 0.5,
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            axisNameSize: 40, // Add extra space here
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                List<String> labels = getLabels();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    labels[value.toInt()],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            axisNameSize: 40,
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40, // Space for numbers on Y axis
                              getTitlesWidget: (double value, TitleMeta meta) {
                                if (value % 500 == 0 || value % 100 == 0) {
                                  return Text(
                                    '${value.toInt()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(), // Show loading indicator while data loads
            ),
          ),
        ),
      ),
    );
  }

  // Convert date to short weekday name
  String getDayOfWeek(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat.E()
          .format(parsedDate); // Short weekday name (Mon, Tue, etc.)
    } catch (e) {
      return date; // If the date is invalid, just return the original string
    }
  }

  List<BarChartGroupData> getBarGroups() {
    if (healthData.isEmpty) return []; // If no data, return empty list

    List<Map<String, dynamic>> values = healthData[selectedDataType]['values'];
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < values.length; i++) {
      String key = values[i].keys.first;
      double numericValue = double.parse(values[i][key]['numeric_value']);

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: numericValue,
              color: Colors.orange, // Use the same orange color
              width: 22, // Adjust the width to match the bar style
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<String> getLabels() {
    if (healthData.isEmpty) return [];

    List<Map<String, dynamic>> values = healthData[selectedDataType]['values'];
    return values.map((value) {
      String key = value.keys.first;
      return getDayOfWeek(key); // Convert date to short day of the week
    }).toList();
  }

  // Calculate the maximum Y value for the chart
  double getMaxYValue() {
    if (healthData.isEmpty) return 0;

    List<Map<String, dynamic>> values = healthData[selectedDataType]['values'];
    double maxValue = 0;

    for (var value in values) {
      double numericValue = double.parse(value.values.first['numeric_value']);
      if (numericValue > maxValue) {
        maxValue = numericValue;
      }
    }

    // Set a ceiling value for better visualization
    return (maxValue + (maxValue * 0.2)).toDouble(); // Adding 20% padding
  }
}
