import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/partials/bottomNavBar.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/fieldmap.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/flipbook.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/home.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/products.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/profile.partials.home.dart';

class HomePageHome extends StatefulHookConsumerWidget {
  const HomePageHome({super.key});

  @override
  ConsumerState<HomePageHome> createState() => _HomePageHomeState();
}

class _HomePageHomeState extends ConsumerState<HomePageHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePartialsHome(),
            ProductsPartialsHome(),
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
