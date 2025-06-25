import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/app/library/home/presentation/widget/imageconvert.widget.home.dart';
import 'package:myapp/app/library/products/presentation/page/video.page.products.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class DetailPageProducts extends StatefulWidget {
  final String image, title, description;

  const DetailPageProducts({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  State<DetailPageProducts> createState() => _DetailPageProductsState();
}

class _DetailPageProductsState extends State<DetailPageProducts> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(deviceSize),
          _buildDescriptionSection(),
        ],
      ),
    );
  }

  Widget _buildAppBar(Size deviceSize) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
      foregroundColor: Colors.white,
      expandedHeight: 300,
      floating: true,
      pinned: true,
      elevation: 8,
      actions: [_buildPlayButton()],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: _buildTitleOverlay(deviceSize),
        background: ImageConvertWidget(base64Image: widget.image),
      ),
    );
  }

  Widget _buildPlayButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fade,
        closedColor: Colors.transparent,
        closedShape: const CircleBorder(),
        closedElevation: 0,
        closedBuilder: (_, openContainer) => Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 170, 0, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 4),
              )
            ],
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Color.fromRGBO(30, 30, 30, 1),
            size: 28,
          ),
        ),
        openBuilder: (_, __) => VideoPageProducts(
          videoTitle: widget.title,
          videoId: "cXmxusAKdzo",
        ),
      ),
    );
  }

  Widget _buildTitleOverlay(Size deviceSize) {
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Color.fromRGBO(0, 0, 0, 0.6),
          ],
        ),
      ),
      child: Text(
        widget.title.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: fontFamily,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          shadows: [
            const Shadow(
              offset: Offset(0, 1),
              blurRadius: 2.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Text(
            widget.description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
