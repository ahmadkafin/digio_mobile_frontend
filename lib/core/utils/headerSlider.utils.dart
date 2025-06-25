import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';
import 'package:myapp/core/utils/styleText.utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Widget> headerCarousel(
    Size deviceSize, List<PanjangPipaResponse> panjangPipa) {
  return [
    carouselOne(deviceSize),
    carouselTwo(deviceSize, panjangPipa),
  ];
}

Widget carouselOne(Size deviceSize) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.map,
            color: Color.fromRGBO(255, 170, 0, 1),
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Pipeline Overview",
            style: TextStyle(
              fontFamily: fontFamily,
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      Divider(),
      Expanded(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'img/basemap_pgn.png',
                semanticLabel: "Basemap DIGIO",
                fit: BoxFit.cover,
                width: deviceSize.width,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Icon(
                  Icons.fullscreen,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget carouselTwo(Size deviceSize, List<PanjangPipaResponse> panjangPipa) {
  return Column(
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
              fontFamily: fontFamily,
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      Divider(),
      Expanded(
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
            majorTickLines: const MajorTickLines(
              width: 0,
            ),
            majorGridLines: const MajorGridLines(
              width: 0,
            ),
          ),
          tooltipBehavior: TooltipBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              format: 'point.x - point.y KM',
              canShowMarker: false,
              header: '',
              textStyle: TextStyle(fontFamily: fontFamily)),
          primaryYAxis: const NumericAxis(
            isVisible: false,
          ),
          series: [
            ColumnSeries<PanjangPipaResponse, String>(
              xValueMapper: (PanjangPipaResponse year, _) => year.tahun,
              // xValueMapper: (PipelineData sales, _) => sales.year,
              yValueMapper: (PanjangPipaResponse panjang, _) => panjang.panjang,
              // yValueMapper: (PipelineData sales, _) => sales.panjang,
              dataSource: panjangPipa,
            )
          ],
        ),
      ),
    ],
  );
}
