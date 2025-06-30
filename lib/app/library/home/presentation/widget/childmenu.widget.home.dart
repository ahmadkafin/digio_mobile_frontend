import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/page/detail.menu.home.page.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class ChildMenuWidgetHome extends HookConsumerWidget {
  const ChildMenuWidgetHome({
    super.key,
    required this.menuResponse,
    required this.deviceSize,
    required this.labelParent,
    required this.iconParent,
    required this.parentId,
    required this.user,
  });

  final List<MenuResponse> menuResponse;
  final String parentId;
  final String labelParent;
  final String iconParent;
  final Size deviceSize;
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayedItems =
        menuResponse.length > 4 ? menuResponse.sublist(0, 4) : menuResponse;

    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < displayedItems.length; i++)
            _buildOpenContainer(
              context: context,
              label: displayedItems[i].label!,
              menu: displayedItems[i],
              isMore: false,
            ),
          if (menuResponse.length > 4)
            _buildOpenContainer(
              context: context,
              label: "Lainnya",
              menu: menuResponse.first,
              isMore: true,
            ),
        ],
      ),
    );
  }

  Widget _buildOpenContainer({
    required BuildContext context,
    required String label,
    required MenuResponse menu,
    required bool isMore,
  }) {
    if (!isMore && menu.haschild != true) {
      return _childContainer(label, menu, isMore);
    }

    return OpenContainer(
      openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      closedShape: const CircleBorder(),
      transitionDuration: const Duration(milliseconds: 500),
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, openContainer) => GestureDetector(
        onTap: openContainer,
        child: _childContainer(label, menu, isMore),
      ),
      openBuilder: (_, __) => _goToPage(label, menu, isMore),
      closedElevation: 0,
      openElevation: 0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
    );
  }

  DetailMenuHomePage _goToPage(String type, MenuResponse menu, bool isMore) {
    return DetailMenuHomePage(
      parrentid: isMore ? parentId : menu.menuid!,
      labelparent: isMore ? labelParent : menu.label!,
      data: menuResponse,
      parentIcon: isMore ? iconParent : menu.iconFlt!,
      type: isMore ? "Lainnya" : menu.label!,
      user: user,
    );
  }

  Widget _childContainer(String type, MenuResponse menu, bool isMore) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: deviceSize.width / 6.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: FaIcon(
                isMore ? FontAwesomeIcons.grip : getIconData(menu.iconFlt!),
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          SizedBox(
            height: Platform.isIOS
                ? deviceSize.height / 30
                : deviceSize.height / 35,
            child: Text(
              isMore ? "Lainnya" : menu.label!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
