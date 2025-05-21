import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselWidgetHome extends StatelessWidget {
  const ImageCarouselWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        child: CarouselSlider(
          items: [1, 2, 3, 4, 5].map(
            (i) {
              return Builder(
                builder: (context) {
                  return Container(
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Image.network(
                        "https://picsum.photos/300/200?random=$i",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
          options: CarouselOptions(
            height: 150,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            pauseAutoPlayOnTouch: true,
          ),
        ),
      ),
    );
  }
}
