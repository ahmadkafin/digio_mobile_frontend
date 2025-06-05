import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';
import 'package:myapp/app/library/home/presentation/page/detail.menu.home.page.dart';
import 'package:myapp/app/library/home/presentation/partials/childrenMenu.partials.home.dart';
import 'package:myapp/app/library/home/presentation/widget/bottomsheetmenu.widget.home.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:myapp/core/utils/gradientColorBackground.utils.dart';

class MenuWidgetHome extends HookConsumerWidget {
  const MenuWidgetHome({
    super.key,
    required this.deviceSize,
    required this.data,
    required this.curIndex,
    required this.setActive,
  });

  final Size deviceSize;
  final List<MenuResponse> data;
  final Function setActive;
  final int curIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double lint = deviceSize.width / deviceSize.height;
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: SizedBox(
        height: 35, // Needed to constrain vertical height
        child: ListView.builder(
          itemBuilder: (context, index) {
            if (data[index].label == 'Help') {
              return null;
            } else {
              return GestureDetector(
                onTap: () => setActive(index, data[index].menuid),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    avatar: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: FaIcon(
                        getIconData(data[index].iconFlt!) ??
                            FontAwesomeIcons.question,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                    label: Text(
                      data[index].label!,
                      overflow: TextOverflow.visible,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: curIndex == index ? Colors.amber : null,
                  ),
                ),
              );
            }
          },
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
