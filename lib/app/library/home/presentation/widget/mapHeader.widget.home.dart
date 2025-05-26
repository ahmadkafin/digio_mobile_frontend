import 'package:flutter/material.dart';

class MapHeaderWidgetHome extends StatelessWidget {
  const MapHeaderWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: deviceSize.height / 7,
        // decoration: BoxDecoration(
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withValues(alpha: 0.5),
        //       spreadRadius: 2,
        //       blurRadius: 10,
        //       offset: Offset(0, 10),
        //     ),
        //   ],
        // ),
        child: Stack(
          alignment: Alignment.topRight,
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
            GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Icon(
                  Icons.fullscreen,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
