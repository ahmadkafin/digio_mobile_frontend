import 'package:flutter/material.dart';

class HeaderWidgetHome extends StatelessWidget {
  const HeaderWidgetHome({
    super.key,
    required this.deviceSize,
    required this.colorsHeader,
  });

  final Size deviceSize;
  final List<Color> colorsHeader;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
      stretch: false,
      expandedHeight: 120,
      snap: false,
      floating: false,
      pinned: true,
      elevation: 8,
      primary: true,
      leading: Image.asset(
        'img/DIGIO_UP.png',
      ),
      leadingWidth: deviceSize.width / 5,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.power_settings_new_outlined,
            color: Colors.white,
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Image.asset(
        //       'img/logo-bumn-indonesia.png',
        //       scale: 8,
        //     ),
        //     Image.asset(
        //       'img/LOGO-AKHLAK-PUTIH.png',
        //       scale: 15,
        //     ),
        //     Image.asset(
        //       'img/ONE-PERTAMINA.png',
        //       scale: 45,
        //     ),
        //     Image.asset(
        //       'img/airman.png',
        //       scale: 45,
        //     ),
        //   ],
        // ),
        centerTitle: true,
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colorsHeader,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'img/logo-bumn-indonesia.png',
                    scale: 8,
                  ),
                  Image.asset(
                    'img/LOGO-AKHLAK-PUTIH.png',
                    scale: 15,
                  ),
                  Image.asset(
                    'img/ONE-PERTAMINA.png',
                    scale: 45,
                  ),
                  Image.asset(
                    'img/airman.png',
                    scale: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}
