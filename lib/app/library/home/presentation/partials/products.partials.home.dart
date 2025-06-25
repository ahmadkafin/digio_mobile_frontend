import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/presentation/widget/imageconvert.widget.home.dart';
import 'package:myapp/app/library/home/providers/products.providers.dart';
import 'package:myapp/app/library/home/repositories/products.repositories.dart';
import 'package:myapp/app/library/products/presentation/page/detail.page.products.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

// --- Tambahan agar hanya fetch sekali
final hasFetchedProductsProvider = StateProvider<bool>((ref) => false);

class ProductsPartialsHome extends ConsumerWidget {
  const ProductsPartialsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    // Cek apakah data sudah pernah di-fetch
    final hasFetched = ref.watch(hasFetchedProductsProvider);

    if (!hasFetched) {
      // fetch hanya sekali
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsProviders.notifier).get("ABC");
        ref.read(hasFetchedProductsProvider.notifier).state = true;
      });
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            _buildProductGrid(size, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      expandedHeight: 200,
      floating: true,
      pinned: true,
      elevation: 8,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Products".toUpperCase(),
          style: TextStyle(
            fontFamily: fontFamily,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        background: Image.asset(
          'img/isometric_scene.png',
          fit: BoxFit.cover,
        ),
        collapseMode: CollapseMode.parallax,
        expandedTitleScale: 1.5,
      ),
    );
  }

  Widget _buildProductGrid(Size size, WidgetRef ref) {
    return ref.watch(getProductsProvider).when(
          loading: () => const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          error: (error, _) => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(child: Text("Error: $error")),
            ),
          ),
          data: (products) {
            if (products.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      "No products available",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 400),
                    closedElevation: 4,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    closedColor: Colors.white,
                    closedBuilder: (context, openContainer) => GestureDetector(
                      onTap: openContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ImageConvertWidget(
                                  base64Image: product.image ?? ""),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.name?.toUpperCase() ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    openBuilder: (context, _) => DetailPageProducts(
                      image: product.image ?? "",
                      title: product.name ?? "",
                      description: product.description ?? "",
                    ),
                  );
                },
              ),
            );
          },
        );
  }
}
