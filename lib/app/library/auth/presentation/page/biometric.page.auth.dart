import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/app/library/auth/providers/refresh_token.providers.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class BiometricPage extends StatefulHookConsumerWidget {
  const BiometricPage({super.key});

  @override
  ConsumerState<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends ConsumerState<BiometricPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _status = "Silakan autentikasi untuk melanjutkan";
  bool _isChecking = false;

  Future<void> _authenticate() async {
    setState(() {
      _isChecking = true;
      _status = "Memeriksa dukungan biometrik...";
    });

    try {
      final isSupported = await _localAuth.isDeviceSupported();
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final biometrics = await _localAuth.getAvailableBiometrics();

      if (!isSupported || !canCheckBiometrics || biometrics.isEmpty) {
        setState(() {
          _status = "Biometrik tidak tersedia atau belum dikonfigurasi.";
          _isChecking = false;
        });
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Silakan autentikasi dengan biometrik Anda',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      setState(() {
        _status = authenticated ? "Autentikasi berhasil" : "Autentikasi gagal";
        _isChecking = false;
      });

      // Lakukan navigasi atau trigger state jika berhasil
      if (authenticated) {
        // call refreshtoken
        ref.read(refreshTokenProvider.notifier).refreshToken().then(
              (res) => res.fold(
                (l) => print(l),
                (r) => print(r),
              ),
            );
      }
    } catch (e) {
      setState(() {
        _status = "Terjadi kesalahan: $e";
        _isChecking = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Opsional: jalankan langsung saat halaman dibuka
    // _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("img/bg_first.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(120),
              BlendMode.darken,
            ),
          ),
        ),
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Transform.scale(
                        scale: 1.5,
                        child: Image.asset(
                          "img/bg_logo_bg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 0.5,
                      child: Image.asset("img/DIGIO_UP.png"),
                    ),
                    // Text(
                    //   'Status: $_status',
                    //   style: TextStyle(
                    //     fontFamily: fontFamily,
                    //     fontSize: 20,
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      _status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (!_isChecking)
                      Container(
                        width: deviceSize.width / 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 15,
                        ),
                        child: TextButton(
                          onPressed: _authenticate,
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(255, 170, 0, 1),
                            foregroundColor:
                                const Color.fromRGBO(30, 30, 30, 1),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.fingerprint, size: 20),
                              const SizedBox(width: 10),
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      const CircularProgressIndicator(
                        color: Color.fromRGBO(255, 170, 0, 1),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
