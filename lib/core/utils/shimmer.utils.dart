import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget horizontalGrid() {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 206, 206, 206),
        highlightColor: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          width: 120,
          height: 120,
        ),
      ),
      itemCount: 4,
    ),
  );
}

Widget chipsShimer() {
  return SizedBox(
    height: 35,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 206, 206, 206),
        highlightColor: const Color.fromARGB(255, 255, 255, 255),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Chip(
            elevation: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            backgroundColor: Colors.amber,
            label: Text("lorem"),
          ),
        ),
      ),
      itemCount: 4,
    ),
  );
}

Widget headerShimmer(Size deviceSize) {
  return Shimmer.fromColors(
    baseColor: const Color.fromARGB(255, 206, 206, 206),
    highlightColor: const Color.fromARGB(255, 255, 255, 255),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: deviceSize.height / 4.3,
      width: deviceSize.width,
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
                    child: Container(
                      child: Text("S"),
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget childMenuShimmer(Size deviceSize) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) => Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: const Color.fromARGB(255, 206, 206, 206),
      highlightColor: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        width: deviceSize.width / 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
    itemCount: 5,
  );
}

Widget productsShimmer(Size deviceSize) {
  return Container(
    color: Colors.transparent,
    child: CarouselSlider(
      items: [1, 2, 3, 4].map((index) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 206, 206, 206),
          highlightColor: const Color.fromARGB(255, 255, 255, 255),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: deviceSize.width,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 150,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
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

Widget productsPartialShimmer() {
  return SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    sliver: SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 206, 206, 206),
          highlightColor: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
