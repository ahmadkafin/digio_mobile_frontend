import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/home/presentation/partials/bottomNavBar.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/fieldmap.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/flipbook.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/home.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/info.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/profile.partials.home.dart';

class HomePageHome extends StatefulWidget {
  const HomePageHome({super.key});

  @override
  State<HomePageHome> createState() => _HomePageHomeState();
}

class _HomePageHomeState extends State<HomePageHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePartialsHome(),
            InfoPartialsHome(),
            FieldMapPartialsHome(),
            FlipBookPartialsHome(),
            ProfilePartialsHome(),
          ],
        ),
        bottomNavigationBar: BottomNavBarPartialsHome(),
      ),
    );
  }
}
