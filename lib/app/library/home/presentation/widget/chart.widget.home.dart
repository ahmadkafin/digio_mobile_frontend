import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidgetHome extends StatelessWidget {
  const ChartWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Colors.white,
      width: deviceSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_up,
                color: Color.fromRGBO(255, 170, 0, 1),
              ),
              Text(
                "Pipeline Growth",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: deviceSize.height / 7,
            child: SfCartesianChart(
              palette: [
                Colors.grey,
              ],
              primaryXAxis: CategoryAxis(
                axisLine: const AxisLine(width: 0),
                labelPosition: ChartDataLabelPosition.outside,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                majorTickLines: const MajorTickLines(width: 0),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                format: 'point.x - point.y KM',
                canShowMarker: false,
                header: '',
              ),
              primaryYAxis: const NumericAxis(
                isVisible: false,
              ),
              series: [
                ColumnSeries<PipelineData, int>(
                  xValueMapper: (PipelineData sales, _) => sales.year,
                  yValueMapper: (PipelineData sales, _) => sales.panjang,
                  dataSource: [
                    PipelineData(2020, 10688.68),
                    PipelineData(2021, 10755.84),
                    PipelineData(2022, 11524.91),
                    PipelineData(2023, 12609.92),
                    PipelineData(2024, 13552.60),
                    PipelineData(2025, 13581.01),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PipelineData {
  PipelineData(this.year, this.panjang);
  final int year;
  final double panjang;
}
