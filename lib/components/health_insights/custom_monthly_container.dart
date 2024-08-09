import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepsReportChart extends StatelessWidget {
  const StepsReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1st Week\nSteps Report',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Average: 7000',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10000,
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      margin: 16,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'W';
                          case 1:
                            return 'T';
                          case 2:
                            return 'F';
                          case 3:
                            return 'S';
                          case 4:
                            return 'S';
                          case 5:
                            return 'M';
                          case 6:
                            return 'T';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      margin: 16,
                      reservedSize: 28,
                      interval: 2000,
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 2000 == 0) {
                          return '${value ~/ 1000}k';
                        }
                        return '';
                      },
                    ),
                    rightTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          y: 5000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          y: 7000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          y: 4000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          y: 8000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          y: 6000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                          y: 7000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                          y: 9000,
                          colors: [Colors.orange, Colors.green],
                          width: 16,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
