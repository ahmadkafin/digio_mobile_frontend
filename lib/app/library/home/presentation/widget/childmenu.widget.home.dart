import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';

class ChildMenuWidgetHome extends StatelessWidget {
  const ChildMenuWidgetHome({
    super.key,
    required this.menuResponse,
    required this.deviceSize,
  });
  final List<MenuResponse> menuResponse;
  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SizedBox(
        height: 60, // Needed to constrain vertical height
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: index == 4 || index == menuResponse.length
                    ? SizedBox(
                        width: deviceSize.width / 6.2,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: FaIcon(
                                FontAwesomeIcons.grip,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Lainnya",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: deviceSize.width / 7,
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: FaIcon(
                                getIconData(
                                  menuResponse[index].iconFlt!,
                                ),
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                menuResponse[index].label!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
          itemCount: menuResponse.length >= 5 ? 5 : menuResponse.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
