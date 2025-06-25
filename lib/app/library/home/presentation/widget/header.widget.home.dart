import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/home/presentation/widget/mapHeader.widget.home.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';
import 'package:myapp/app/library/settings/presentation/page/settings.page.dart';

class HeaderWidgetHome extends StatelessWidget {
  const HeaderWidgetHome({
    super.key,
    required this.deviceSize,
    required this.colorsHeader,
    required this.controller,
    required this.stateIndex,
    required this.curr,
    required this.panjangPipa,
  });

  final Size deviceSize;
  final List<Color> colorsHeader;
  final CarouselSliderController controller;
  final Function stateIndex;
  final int curr;
  final List<PanjangPipaResponse> panjangPipa;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color.fromRGBO(30, 30, 30, 1),
      stretch: false,
      expandedHeight: 320,
      snap: false,
      floating: false,
      pinned: true,
      elevation: 8,
      primary: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: Image.asset(
          'img/DIGIO_UP.png',
        ),
      ),
      leadingWidth: deviceSize.width / 5,
      actions: [
        OpenContainer(
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return IconButton(
              onPressed: openContainer,
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            );
          },
          openBuilder: (BuildContext _, VoidCallback action) {
            return SettingsPage();
          },
          transitionType: ContainerTransitionType.fade,
          closedColor: Colors.transparent,
          closedElevation: 0,
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
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
        centerTitle: true,
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colorsHeader,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 0,
                    left: 10,
                    right: 10,
                  ),
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
                SizedBox(
                  child: MapHeaderWidgetHome(
                    deviceSize: deviceSize,
                    controller: controller,
                    curr: curr,
                    stateIndex: stateIndex,
                    panjangPipa: panjangPipa,
                  ),
                ),
              ],
            ),
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }
}
