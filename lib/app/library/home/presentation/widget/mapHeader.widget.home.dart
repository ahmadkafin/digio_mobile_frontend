import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/home/response/panjangpipa.response.dart';
import 'package:myapp/core/utils/headerSlider.utils.dart';

class MapHeaderWidgetHome extends StatelessWidget {
  const MapHeaderWidgetHome({
    super.key,
    required this.deviceSize,
    required this.controller,
    required this.stateIndex,
    required this.curr,
    required this.panjangPipa,
  });

  final Size deviceSize;
  final CarouselSliderController controller;
  final Function stateIndex;
  final int curr;
  final List<PanjangPipaResponse> panjangPipa;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: deviceSize.height / 4.3,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withValues(alpha: 0.5),
      //       spreadRadius: 2,
      //       blurRadius: 10,
      //       offset: Offset(0, 10),
      //     ),
      //   ],
      // ),
      child: Card(
        elevation: 8,
        child: Container(
          height: deviceSize.height,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2), // soft light gray (off-white)
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: CarouselSlider(
                    carouselController: controller,
                    items: headerCarousel(deviceSize, panjangPipa),
                    options: CarouselOptions(
                      height: deviceSize.height,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 1500),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      pauseAutoPlayOnTouch: true,
                      onPageChanged: (index, reason) => stateIndex(index),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: headerCarousel(deviceSize, panjangPipa)
                      .asMap()
                      .entries
                      .map(
                    (entry) {
                      return GestureDetector(
                        onTap: () => controller.animateToPage(entry.key),
                        child: Container(
                          width: curr == entry.key ? 10 : 6,
                          height: 6,
                          margin: EdgeInsets.symmetric(
                            vertical: 1.0,
                            horizontal: 2.0,
                          ),
                          decoration: BoxDecoration(
                            shape: curr == entry.key
                                ? BoxShape.rectangle
                                : BoxShape.circle,
                            borderRadius: curr == entry.key
                                ? BorderRadius.all(Radius.circular(20))
                                : null,
                            color:
                                curr == entry.key ? Colors.amber : Colors.black,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
