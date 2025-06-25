import 'package:flutter/material.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'img/bg_first.png',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(120),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: deviceSize.width / 1.2,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Image.asset(
                            "img/bg_logo_bg.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: deviceSize.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.scale(
                        scale: 0.5,
                        child: Image.asset(
                          "img/DIGIO_UP.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "Please Wait\n",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  CircularProgressIndicator(
                    color: Color.fromRGBO(255, 170, 0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
