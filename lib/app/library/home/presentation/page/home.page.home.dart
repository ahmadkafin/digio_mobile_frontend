import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/partials/bottomNavBar.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/fieldmap.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/flipbook.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/home.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/products.partials.home.dart';
import 'package:myapp/app/library/home/presentation/partials/profile.partials.home.dart';
import 'package:myapp/core/utils/dio_client.utils.dart';

class HomePageHome extends StatefulHookConsumerWidget {
  const HomePageHome({super.key});

  @override
  ConsumerState<HomePageHome> createState() => _HomePageHomeState();
}

class _HomePageHomeState extends ConsumerState<HomePageHome> {
  bool _isDialogShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupDioInterceptor(
      onTokenAlmostExpired: () {
        if (!mounted || _isDialogShown) return;
        _isDialogShown = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            title: const Text("Sesi Hampir Habis"),
            content: const Text(
                "Sesi Anda akan berakhir dalam 30 detik. Perpanjang sekarang?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _isDialogShown = false;
                  // TODO: panggil refresh token di sini jika ada
                },
                child: const Text("Perpanjang"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _isDialogShown = false;
                },
                child: const Text("Abaikan"),
              ),
            ],
          ),
        );
      },
    );
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
