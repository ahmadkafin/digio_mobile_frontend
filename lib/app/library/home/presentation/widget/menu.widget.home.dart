import 'package:flutter/material.dart';
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
  });

  final Size deviceSize;
  final List<MenuResponse> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        width: deviceSize.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChildrenMenuPartials(data: data, index: 0),
            ChildrenMenuPartials(data: data, index: 1),
            ChildrenMenuPartials(data: data, index: 2),
            ChildrenMenuPartials(data: data, index: 3),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext ctx) {
                    return BottomSheetMenWidgetHome(
                      deviceSize: deviceSize,
                      data: data,
                    );
                  },
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.clamp,
                        colors: getColorData("Lainnya") ??
                            [
                              Colors.deepOrange,
                              Colors.black,
                            ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.apps_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  Text(
                    "Lainnya",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
