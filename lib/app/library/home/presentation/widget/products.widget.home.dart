import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/products/presentation/page/detail.page.products.dart';

class ProductsWidgetHome extends StatelessWidget {
  const ProductsWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Color.fromRGBO(30, 30, 30, 1),
              stretch: false,
              expandedHeight: 200,
              snap: false,
              floating: false,
              pinned: true,
              elevation: 8,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Products".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'img/isometric_scene.png',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black38,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 1.5,
              ),
            ),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 25,
              itemBuilder: (context, index) {
                return OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  closedBuilder: (BuildContext _, VoidCallback openContainer) {
                    return GestureDetector(
                      onTap: openContainer,
                      child: Card(
                        color: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: Image.network(
                                "https://picsum.photos/300/200?random=$index",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                color: Colors.white,
                                child: Text(
                                  "lorem ipsum dolor sit amet",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return DetailPageProducts(
                      image: "https://picsum.photos/300/200?random=$index",
                      title: index.toString(),
                    );
                  },
                  onClosed: (data) => print("closed"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
