import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:helix_ai/constants/colors.dart';
import 'package:intl/intl.dart';

class Healthbarchart extends StatefulWidget {
  const Healthbarchart({super.key});

  @override
  State<Healthbarchart> createState() => _HealthbarchartState();
}

class _HealthbarchartState extends State<Healthbarchart> {
  String selectedDataType = 'STEPS'; // Default to STEPS
  Map<String, dynamic> healthData = {
    "STEPS": {
      "unit": "COUNT",
      "values": [
        {
          "2024-08-27": {"numeric_value": "1500"}
        },
        {
          "2024-08-28": {"numeric_value": "1000"}
        },
        {
          "2024-08-29": {"numeric_value": "4000"}
        },
        {
          "2024-08-30": {"numeric_value": "3000"}
        },
        {
          "2024-08-31": {"numeric_value": "5000"}
        }
      ]
    },
  };

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
              child: BarChart(
                BarChartData(
                  maxY: getMaxYValue(),
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: getBarGroups(),
                  barTouchData:
                  BarTouchData(enabled: false), // Disable touch interaction
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
                          if (value % 5000 == 0 || value % 1000 == 0) {
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
              ),
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
    List<Map<String, dynamic>> values = healthData[selectedDataType]['values'];
    return values.map((value) {
      String key = value.keys.first;
      return getDayOfWeek(key); // Convert date to short day of the week
    }).toList();
  }

  // Calculate the maximum Y value for the chart
  double getMaxYValue() {
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
