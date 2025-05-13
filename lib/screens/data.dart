import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de imagen
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset('assets/images/bg1.jpg', fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Histograma
                Card(
                  color: Colors.white.withOpacity(
                    0.6,
                  ), // Fondo semi-transparente
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Histograma',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(height: 300, child: HistogramChart()),
                      ],
                    ),
                  ),
                ),

                // LineChart Sample 2
                Card(
                  color: Colors.white.withOpacity(
                    0.6,
                  ), // Fondo semi-transparente
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gráfico de Líneas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(height: 300, child: LineChartSample2()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// === HISTOGRAMA ===
class HistogramChart extends StatelessWidget {
  HistogramChart({super.key});

  final List<int> frequencies = [2, 5, 8, 4, 3];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, _) => Text(value.toInt().toString()),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final labels = ['0-10', '11-20', '21-30', '31-40', '41-50'];
                return Text(
                  labels[value.toInt()],
                  style: const TextStyle(fontSize: 12),
                );
              },
              reservedSize: 32,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(frequencies.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: frequencies[i].toDouble(),
                width: 20,
                borderRadius: BorderRadius.circular(4),
                color: Colors.deepPurple,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// === LINE CHART SAMPLE 2 ===
class LineChartSample2 extends StatelessWidget {
  const LineChartSample2({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 6,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 1),
              FlSpot(2, 4),
              FlSpot(3, 3.5),
              FlSpot(4, 4),
              FlSpot(5, 2),
            ],
            isCurved: true,
            color: Colors.orange,
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.3),
            ),
            dotData: FlDotData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, _) => Text('T${value.toInt()}'),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, _) => Text(value.toInt().toString()),
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: const Border(bottom: BorderSide(), left: BorderSide()),
        ),
      ),
    );
  }
}
