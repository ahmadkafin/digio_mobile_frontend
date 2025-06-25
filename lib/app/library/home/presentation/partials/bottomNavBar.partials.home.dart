import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class BottomNavBarPartialsHome extends StatelessWidget {
  const BottomNavBarPartialsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: [
        TabItem(icon: Icons.home, title: "Home", fontFamily: fontFamily),
        TabItem(
          icon: Icons.inventory,
          title: "Product",
          fontFamily: fontFamily,
        ),
        TabItem(
          icon: Icons.map,
          title: "Field Map",
          fontFamily: fontFamily,
        ),
        TabItem(
          icon: Icons.book,
          title: "Infra Book",
          fontFamily: fontFamily,
        ),
        TabItem(
          icon: Icons.person,
          title: "Profile",
          fontFamily: fontFamily,
        ),
      ],
      // items: [...homePartial.items()],
      color: Colors.black,
      activeColor: Color.fromRGBO(255, 170, 0, 1),
      backgroundColor: Colors.white,
      style: TabStyle.fixedCircle,
      elevation: 8,
    );
  }
}
