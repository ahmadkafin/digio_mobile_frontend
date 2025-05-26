import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/pipelen/presentation/page/detail.pipelen.page.dart';

class PipeLineLengthWidgetHome extends StatelessWidget {
  const PipeLineLengthWidgetHome({
    super.key,
    required this.deviceSize,
    required this.dt,
  });

  final Size deviceSize;
  final String dt;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'img/icon-d/Valve-icon.png',
                      scale: 15,
                      color: Color.fromRGBO(255, 170, 0, 1),
                    ),
                    Text(
                      "Pipeline Length",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "img/icon-d/Pipeline-length.png",
                  scale: 10,
                  color: Color.fromRGBO(255, 170, 0, 1),
                ),
                Text(
                  "33.288,26 KM",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(
                  indent: 5,
                  endIndent: 5,
                ),
                Text(
                  dt,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (BuildContext _, closeContainer) {
        return DetailPipeLenPage(
          dt: dt,
        );
      },
      transitionType: ContainerTransitionType.fade,
    );
  }
}
