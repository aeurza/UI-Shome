import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({Key? key}) : super(key: key);

  // Datos para el SparkLine
  static const List<double> sparklineData = [30, 40, 20, 50, 35];

  // Datos para el gráfico circular tipo donut
  static const List<_PieData> pieData = [
    _PieData('A', 20, '20%'),
    _PieData('B', 30, '30%'),
    _PieData('C', 15, '15%'),
    _PieData('D', 25, '25%'),
    _PieData('E', 10, '10%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Estadísticas')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.fill),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // SparkLine Chart
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      child: SfSparkLineChart(
                        data: sparklineData,
                        marker: const SparkChartMarker(
                          displayMode: SparkChartMarkerDisplayMode.all,
                        ),
                        labelDisplayMode: SparkChartLabelDisplayMode.all,
                        trackball: const SparkChartTrackball(
                          activationMode: SparkChartActivationMode.tap,
                        ),
                      ),
                    ),
                  ),
                ),

                // Gráfico circular tipo donut
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      child: SfCircularChart(
                        title: ChartTitle(text: 'Distribución porcentual'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <DoughnutSeries<_PieData, String>>[
                          DoughnutSeries<_PieData, String>(
                            radius: '80%',
                            innerRadius: '60%',
                            dataSource: pieData,
                            xValueMapper: (_PieData data, _) => data.xData,
                            yValueMapper: (_PieData data, _) => data.yData,
                            dataLabelMapper: (_PieData data, _) => data.text,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                            enableTooltip: true,
                            animationDuration: 1000,
                          ),
                        ],
                      ),
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

// Clase para datos del gráfico circular
class _PieData {
  final String xData;
  final num yData;
  final String? text;
  const _PieData(this.xData, this.yData, [this.text]);
}
