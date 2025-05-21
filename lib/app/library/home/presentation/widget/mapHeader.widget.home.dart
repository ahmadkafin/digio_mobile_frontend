import 'package:flutter/material.dart';

class MapHeaderWidgetHome extends StatelessWidget {
  const MapHeaderWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        height: deviceSize.height / 7.5,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: deviceSize.width,
              height: deviceSize.height / 5.5,
              child: Image.asset(
                'img/basemap_pgn.png',
                semanticLabel: "Basemap DIGIO",
                fit: BoxFit.cover,
                width: deviceSize.width,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    width: deviceSize.width / 2.5,
                    child: Center(
                      child: Text(
                        "Bar Chart",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(255, 165, 31, 0.6),
                    width: deviceSize.width / 2.5,
                    child: Center(
                      child: Text(
                        "Pipa",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
