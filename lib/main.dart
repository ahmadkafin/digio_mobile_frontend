import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';
import 'package:myapp/app/library/home/presentation/page/home.page.home.dart';
import 'package:myapp/app/library/testScreen/test.screen.dart';
import 'package:myapp/landing_main.dart';
import 'package:myapp/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    ProviderScope(
      // child: SplashScreen(),
      child: LandingMain(),
      // child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digio Mobile",
      home: TestScreen(),
    );
  }
}
