import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/presentation/page/biometric.page.auth.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';
import 'package:myapp/app/library/auth/repositories/authstorage.repositories.dart';
import 'package:myapp/app/library/home/presentation/page/home.page.home.dart';
import 'package:myapp/app/library/splashscreen/providers/splashscreen.providers.dart';
import 'package:myapp/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingMain extends StatefulHookConsumerWidget {
  const LandingMain({super.key});

  @override
  ConsumerState<LandingMain> createState() => _LandingMainState();
}

class _LandingMainState extends ConsumerState<LandingMain> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _isActivate = false;
  bool _isConnectionActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(splashScreenProviders.notifier).get();
    isConnectionIsActive();
    isActivateBiometrics();
  }

  Future<void> isActivateBiometrics() async {
    final sp = await SharedPreferences.getInstance();
    _isActivate = sp.getBool('isBiometricActive') ?? false;
  }

  Future<void> isConnectionIsActive() async {}

  @override
  Widget build(BuildContext context) {
    final splashScreenState = ref.watch(splashScreenProviders);
    return splashScreenState.when(
      error: (e, st) {
        return MaterialApp(
          title: "Digio Mobile",
          home: SplashScreen(),
        );
      },
      loading: () => MaterialApp(
        title: "Digio Mobile",
        home: SplashScreen(),
      ),
      data: (isValidToken) {
        if (isValidToken) {
          return MaterialApp(
            title: "Digio Mobile",
            home: const HomePageHome(),
          );
        } else {
          final authState = ref.watch(isAuthProvider);
          return authState.when(
            data: (isAuth) {
              return MaterialApp(
                navigatorKey: _navigatorKey,
                title: "Digio Mobile",
                home: isAuth
                    ? HomePageHome()
                    : _isActivate
                        ? BiometricPage()
                        : LoginPageAuth(),
              );
            },
            error: (_, st) => MaterialApp(
              navigatorKey: _navigatorKey,
              title: "Digio Mobile",
              home: LoginPageAuth(),
            ),
            loading: () => MaterialApp(
              title: "Digio Mobile",
              home: SplashScreen(),
            ),
          );
        }
      },
    );
  }
}
