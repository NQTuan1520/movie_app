import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.dailyStats,
  });

  final Map<String, int> dailyStats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          swapAnimationDuration: const Duration(milliseconds: 350),
          swapAnimationCurve: Curves.linear,
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: (dailyStats.values.reduce((a, b) => a > b ? a : b) / 3600),
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < dailyStats.keys.length) {
                      final date = DateFormat('yyyy-MM-dd')
                          .parse(dailyStats.keys.elementAt(index));
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${DateFormat('EEE').format(date)}\n${DateFormat('MM/dd').format(date)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      );
                    } else {
                      return const Text("");
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      ' ${(value * 1).toStringAsFixed(0)} h',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              verticalInterval: 1,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (value) => value % 1 == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: Colors.grey.shade800,
                strokeWidth: 1,
              ),
              getDrawingVerticalLine: (value) => FlLine(
                color: Colors.grey.shade800,
                strokeWidth: 1,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.grey.shade800,
                width: 1,
              ),
            ),
            barGroups: dailyStats.entries.map((entry) {
              final index = dailyStats.keys.toList().indexOf(entry.key);
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: (entry.value.toDouble() / 3600).toDouble(),
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.deepPurpleAccent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    width: 12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
