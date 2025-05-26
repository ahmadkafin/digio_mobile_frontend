import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/partials/bottomNavBar.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/fieldmap.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/flipbook.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/home.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/profile.partials.home.dart';
import 'package:myapp/app/library/home/presentation/widget/products.widget.home.dart';
import 'package:myapp/app/library/home/providers/root.menu.providers.dart';
import 'package:myapp/app/library/home/repositories/root.menu.repositories.dart';

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
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePartialsHome(),
            ProductsWidgetHome(),
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
