import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/library/home/presentation/widget/chart.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/childmenu.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/header.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/mapHeader.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/horizontalgrid.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/menu.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/imageCarousel.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/pipelinelength.widget.home.dart';
import 'package:myapp/app/library/home/providers/child.menu.providers.dart';
import 'package:myapp/app/library/home/providers/home.providers.dart';
import 'package:myapp/app/library/home/providers/root.menu.providers.dart';
import 'package:myapp/app/library/home/repositories/child.menu.repositories.dart';
import 'package:myapp/app/library/home/repositories/home.repositories.dart';
import 'package:myapp/app/library/home/repositories/root.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:myapp/core/utils/fontAwesomeMapping.utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePartialsHome extends StatefulHookConsumerWidget {
  const HomePartialsHome({
    super.key,
  });
  @override
  ConsumerState<HomePartialsHome> createState() => _HomePartialsHomeState();
}

class _HomePartialsHomeState extends ConsumerState<HomePartialsHome> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;
  int currentIndex = 0;
  List<MenuResponse>? childMenuResponse;

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
    Future.microtask(
      () {
        ref.read(rootMenuProviders.notifier).get("abcdef").then(
              (res) => {
                res.fold(
                  (l) => null,
                  (r) => ref
                      .read(childMenuProviders.notifier)
                      .get("token", r[0].menuid!),
                ),
              },
            );
        ref.read(homeProviders.notifier).get("abc");
      },
    );
  }

  void stateIndex(index) {
    setState(() {
      _current = index;
    });
  }

  void setActive(index, parrentid) {
    setState(() {
      currentIndex = index;
    });
    ref.read(childMenuProviders.notifier).get("ABC", parrentid).then(
          (res) => res.fold(
            (l) => null,
            (r) => childMenuResponse = r,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<Color> colorsHeader = [
      Colors.black,
      Color.fromRGBO(75, 75, 75, 1),
    ];
    String dt = DateFormat("MMMM yyyy").format(DateTime.now());
    return SafeArea(
      top: false,
      child: Container(
        color: Color.fromRGBO(30, 30, 30, 1),
        child: CustomScrollView(
          slivers: [
            HeaderWidgetHome(
              deviceSize: deviceSize,
              colorsHeader: colorsHeader,
              controller: _controller,
              curr: _current,
              stateIndex: stateIndex,
            ),
            SliverToBoxAdapter(
              // section 1
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                width: deviceSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Color.fromRGBO(242, 226, 190, 1),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    ref.watch(getHomeProvider).when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  "No Data Found",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            } else {
                              return HorizontalGridHeaderWidgetHome(
                                deviceSize: deviceSize,
                                data: data,
                              );
                            }
                          },
                          error: (error, stackTrace) => Center(
                            child: Text(
                              "error.toString()",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    _menuLoad(deviceSize, setActive, currentIndex),
                    // child widget
                    ref.watch(getChildMenuProvider).when(
                          data: (menuResponse) => ChildMenuWidgetHome(
                            menuResponse: menuResponse,
                            deviceSize: deviceSize,
                          ),
                          error: (error, stackTrace) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    // child widget
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              // section 2
              child: Container(
                width: deviceSize.width,
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      width: deviceSize.width,
                      padding: const EdgeInsets.only(top: 25, left: 10),
                      child: Text(
                        "#WhatsInDigio",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ImageCarouselWidgetHome(deviceSize: deviceSize),
                    Container(
                      width: deviceSize.width,
                      padding: const EdgeInsets.only(top: 25, left: 10),
                      child: Text(
                        "PGN #SeputarOMM",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    ImageCarouselWidgetHome(deviceSize: deviceSize),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _menuLoad(Size deviceSize, Function setActive, int curIndex) {
    return ref.watch(getRootMenuProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text("Empty data"),
              );
            } else {
              return MenuWidgetHome(
                deviceSize: deviceSize,
                data: data,
                curIndex: curIndex,
                setActive: setActive,
              );
            }
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          },
          loading: () => Container(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
