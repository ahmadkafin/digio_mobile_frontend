import 'package:flutter/material.dart';

class DetailPageBanner extends StatelessWidget {
  const DetailPageBanner({
    super.key,
    required this.image,
    required this.title,
  });
  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(30, 30, 30, 1),
            foregroundColor: Colors.white,
            stretch: false,
            expandedHeight: 300,
            snap: true,
            floating: true,
            pinned: true,
            elevation: 8,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Container(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
