import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/utils/styleText.utils.dart';
import 'package:shimmer/shimmer.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 3,
          trackGap: 0,
        ),
      ),
    );
  }
}
