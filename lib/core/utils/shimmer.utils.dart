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
