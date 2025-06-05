import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/page/detail.menu.home.page.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:myapp/core/utils/gradientColorBackground.utils.dart';

class ChildrenMenuPartials extends HookConsumerWidget {
  const ChildrenMenuPartials({
    super.key,
    required this.data,
    required this.index,
  });
  final List<MenuResponse> data;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref
          .read(childMenuProviders.notifier)
          .get("ABC", data[0].menuid!)
          .then(
            (res) => res.fold(
              (l) => [],
              (r) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailMenuHomePage(
                    parrentid: data[index].menuid!,
                    labelparent: data[index].label!,
                    parentIcon: data[index].iconFlt!,
                    data: r,
                  ),
                ),
              ),
            ),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: getColorData(data[index].label!) ??
              //       [
              //         Colors.deepOrange,
              //         Colors.black,
              //       ],
              // ),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(),
                child: FaIcon(
                  getIconData(data[index].iconFlt!),
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
          Text(
            data[index].label!,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
