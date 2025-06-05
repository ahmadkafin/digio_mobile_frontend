import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/repositories/products.repositories.dart';
import 'package:myapp/app/library/products/presentation/page/detail.page.products.dart';

class ProductsWidgetHome extends HookConsumerWidget {
  const ProductsWidgetHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Color.fromRGBO(30, 30, 30, 1),
              stretch: false,
              expandedHeight: 200,
              snap: true,
              floating: true,
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
                background: SizedBox(
                  child: Image.asset(
                    'img/isometric_scene.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // background: Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //         'img/isometric_scene.png',
                //       ),
                //       fit: BoxFit.cover,
                //       colorFilter: ColorFilter.mode(
                //         Colors.black38,
                //         BlendMode.darken,
                //       ),
                //     ),
                //   ),
                // ),
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 1.5,
              ),
            ),
            // add ref here
            ref.watch(getProductsProvider).when(
                loading: () => SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stackTrace) => SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "Nothing to show here",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                data: (data) {
                  if (data.isNotEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "Nothing to show here",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return OpenContainer(
                          transitionType: ContainerTransitionType.fade,
                          closedBuilder:
                              (BuildContext _, VoidCallback openContainer) {
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
                              image:
                                  "https://picsum.photos/300/200?random=$index",
                              title: index.toString(),
                            );
                          },
                          onClosed: (data) => print("closed"),
                        );
                      },
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
