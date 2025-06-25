import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/page/detail.menu.home.page.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:myapp/core/utils/gradientColorBackground.utils.dart';
import 'package:page_transition/page_transition.dart';

class BottomSheetMenWidgetHome extends HookConsumerWidget {
  const BottomSheetMenWidgetHome({
    super.key,
    required this.deviceSize,
    required this.data,
    required this.user,
  });

  final Size deviceSize;
  final List<MenuResponse> data;
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height / 2.5,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                childAspectRatio: 1,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => ref
                      .read(childMenuProviders.notifier)
                      .get("ABC", 'ahmad.kafin-e', 'PERTAMINA',
                          data[index].menuid!)
                      .then(
                        (res) => res.fold(
                          (l) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMenuHomePage(
                                parrentid: data[index].menuid!,
                                labelparent: data[index].label!,
                                parentIcon: data[index].iconFlt!,
                                data: l,
                                type: "Lainnya",
                                user: user,
                              ),
                            ),
                          ),
                          (r) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMenuHomePage(
                                parrentid: data[index].menuid!,
                                labelparent: data[index].label!,
                                data: r,
                                parentIcon: data[index].iconFlt!,
                                type: "Lainnya",
                                user: user,
                              ),
                            ),
                          ),
                        ),
                      ),
                  child: GridTile(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              tileMode: TileMode.clamp,
                              colors: getColorData(data[index].label!) ??
                                  [
                                    Colors.deepOrange,
                                    Colors.black,
                                  ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: FaIcon(
                              getIconData(data[index].iconFlt!) ??
                                  FontAwesomeIcons.question,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data[index].label!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
