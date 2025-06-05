import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/banner/presentation/page/detail.page.banner.dart';

class ImageCarouselWidgetHome extends StatelessWidget {
  const ImageCarouselWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
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
                  child: OpenContainer(
                    closedBuilder:
                        (BuildContext _, VoidCallback openContainer) {
                      return ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.bottomRight,
                          children: [
                            Positioned(
                              width: deviceSize.width,
                              child: Image.network(
                                "https://picsum.photos/1920/1080?random=$i",
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                width: 135,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Lebih Lanjut",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    openBuilder: (BuildContext _, VoidCallback closeContainer) {
                      return DetailPageBanner(
                        image: "https://picsum.photos/1920/1080?random=$i",
                        title: i.toString(),
                      );
                    },
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
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          pauseAutoPlayOnTouch: true,
        ),
      ),
    );
  }
}
