import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

OpenContainer openContainer(
  Widget openContainerWidget,
  Widget closeContainerWidget,
) {
  return OpenContainer(
    closedColor: Colors.amber,
    closedElevation: 0,
    openElevation: 0,
    tappable: true,
    closedBuilder: (BuildContext _, VoidCallback openContainer) => Container(
      child: GestureDetector(
        onTap: () => openContainer,
        child: openContainerWidget,
      ),
    ),
    openBuilder: (BuildContext _, VoidCallback closeContainer) =>
        closeContainerWidget,
    transitionType: ContainerTransitionType.fadeThrough,
  );
}
