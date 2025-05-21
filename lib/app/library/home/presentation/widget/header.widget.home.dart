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
    return Expanded(
      flex: 3,
      child: Container(
        width: deviceSize.width,
        height: deviceSize.height / 5.5,
        padding: const EdgeInsets.only(bottom: 10, top: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorsHeader,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'img/DIGIO_UP.png',
                    scale: 6,
                  ),
                  Divider(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
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
                      scale: 35,
                    ),
                    Image.asset(
                      'img/airman.png',
                      scale: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
