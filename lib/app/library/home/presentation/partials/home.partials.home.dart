import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/app/library/home/presentation/widget/header.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/horizontalgrid.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/imageCarousel.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/mapHeader.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/menu.widget.home.dart';

class HomePartialsHome extends StatefulWidget {
  const HomePartialsHome({super.key});

  @override
  State<HomePartialsHome> createState() => _HomePartialsHomeState();
}

class _HomePartialsHomeState extends State<HomePartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemStatusBarContrastEnforced: true,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<Color> colorsHeader = [
      Color.fromRGBO(20, 30, 48, 1),
      Color.fromRGBO(36, 59, 85, 1),
      Color.fromRGBO(96, 108, 136, 1),
      Color.fromRGBO(63, 76, 107, 1),
    ];
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: deviceSize.width,
                height: deviceSize.height / 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colorsHeader),
                ),
              ),
            ),
            HeaderWidgetHome(
              deviceSize: deviceSize,
              colorsHeader: colorsHeader,
            ),
            MapHeaderWidgetHome(deviceSize: deviceSize),
            HorizontalGridHeaderWidgetHome(deviceSize: deviceSize),
            MenuWidgetHome(deviceSize: deviceSize),
            ImageCarouselWidgetHome(deviceSize: deviceSize),
          ],
        ),
      ),
    );
  }
}
