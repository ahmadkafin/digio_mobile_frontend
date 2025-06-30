import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/app/library/home/presentation/widget/imageconvert.widget.home.dart';
import 'package:myapp/app/library/home/response/products.response.dart';
import 'package:myapp/app/library/products/presentation/page/detail.page.products.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class ImageCarouselWidgetHome extends StatelessWidget {
  const ImageCarouselWidgetHome({
    super.key,
    required this.deviceSize,
    required this.products,
  });

  final Size deviceSize;
  final List<ProductsResponse> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: CarouselSlider(
        items: products.map((product) {
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
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://digio.pgn.co.id/digiomobilebe/static/images/products/${product.image}',
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: FaIcon(
                                  FontAwesomeIcons.question,
                                  size: 40,
                                ),
                              ),
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
                                      fontFamily: fontFamily,
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
                    return DetailPageProducts(
                      description: product.description.toString(),
                      image: product.image.toString(),
                      title: product.name.toString(),
                      video: product.video ?? "",
                    );
                  },
                ),
              );
            },
          );
        }).toList(),
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
