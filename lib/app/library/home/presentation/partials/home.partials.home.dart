import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myapp/app/library/home/presentation/widget/chart.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/header.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/mapHeader.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/horizontalgrid.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/menu.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/imageCarousel.widget.home.dart';
import 'package:myapp/app/library/home/presentation/widget/pipelinelength.widget.home.dart';
import 'package:myapp/app/library/home/providers/root.menu.providers.dart';
import 'package:myapp/app/library/home/repositories/root.menu.repositories.dart';
import 'package:myapp/app/library/home/response/menu.response.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePartialsHome extends StatefulHookConsumerWidget {
  const HomePartialsHome({
    super.key,
  });
  @override
  ConsumerState<HomePartialsHome> createState() => _HomePartialsHomeState();
}

class _HomePartialsHomeState extends ConsumerState<HomePartialsHome> {
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
    Future.microtask(() {
      ref.read(rootMenuProviders.notifier).get("abcdef");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<Color> colorsHeader = [
      Color.fromRGBO(20, 30, 48, 1),
      // Color.fromRGBO(36, 59, 85, 1),
      // Color.fromRGBO(96, 108, 136, 1),
      Color.fromRGBO(63, 76, 107, 1),
    ];
    String dt = DateFormat("MMMM yyyy").format(DateTime.now());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HeaderWidgetHome(
              deviceSize: deviceSize,
              colorsHeader: colorsHeader,
            ),
            MapHeaderWidgetHome(deviceSize: deviceSize),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      ChartWidgetHome(deviceSize: deviceSize),
                      PipeLineLengthWidgetHome(
                        deviceSize: deviceSize,
                        dt: dt,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // HorizontalGridHeaderWidgetHome(deviceSize: deviceSize),
            ref.watch(getRootMenuProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text("Empty data"),
                        ),
                      );
                    } else {
                      return MenuWidgetHome(deviceSize: deviceSize, data: data);
                    }
                  },
                  error: (error, stackTrace) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          error.toString(),
                        ),
                      ),
                    );
                  },
                  loading: () => SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  ),
                ),
            SliverToBoxAdapter(
              child: Container(
                width: deviceSize.width,
                padding: const EdgeInsets.only(top: 25, left: 10),
                color: Colors.white,
                child: Text(
                  "PGN #SeputarOMM",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ImageCarouselWidgetHome(deviceSize: deviceSize),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Divider(
                  thickness: 5,
                  color: Colors.white,
                  indent: 15,
                  endIndent: 15,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
