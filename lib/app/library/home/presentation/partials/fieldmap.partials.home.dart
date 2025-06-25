import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class FieldMapPartialsHome extends StatefulWidget {
  const FieldMapPartialsHome({super.key});

  @override
  State<FieldMapPartialsHome> createState() => _FieldMapPartialsHomeState();
}

class _FieldMapPartialsHomeState extends State<FieldMapPartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init field map");
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Field map".toUpperCase(),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        width: deviceSize.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRedSpot(deviceSize),
            _customDivider(deviceSize),
            _buildAnomaly(deviceSize),
          ],
        ),
      ),
    );
  }

  Container _customDivider(Size deviceSize) {
    return Container(
      height: 2,
      width: deviceSize.width / 1.1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.blue,
            Colors.purple,
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Expanded _buildRedSpot(Size deviceSize) {
    return Expanded(
      flex: 1,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Container(
                width: deviceSize.width * 0.95,
                height: deviceSize.height * 0.6,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  image: DecorationImage(
                    image: AssetImage('img/redspot_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                  child: Container(
                    width: deviceSize.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    color: Colors.amber,
                    height: deviceSize.height / 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Open Redspot",
                          style: TextStyle(
                              fontFamily: fontFamily,
                              color: Color.fromRGBO(30, 30, 30, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color.fromRGBO(30, 30, 30, 1),
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildAnomaly(Size deviceSize) {
    return Expanded(
      flex: 1,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Container(
                width: deviceSize.width * 0.95,
                height: deviceSize.height * 0.6,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 30, 30, 1),
                  image: DecorationImage(
                    image: AssetImage('img/anomaly_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                  child: Container(
                    width: deviceSize.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    color: Colors.amber,
                    height: deviceSize.height / 14,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Open Anomaly",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: Color.fromRGBO(30, 30, 30, 1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color.fromRGBO(30, 30, 30, 1),
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
