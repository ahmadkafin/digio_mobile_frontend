import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/miracle/providers/miracle.providers.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class MiraclePagePresentation extends StatefulHookConsumerWidget {
  const MiraclePagePresentation({
    super.key,
    required this.title,
    required this.parentMenuId,
  });
  final String title;
  final String? parentMenuId;

  @override
  ConsumerState<MiraclePagePresentation> createState() =>
      _MiraclePagePresentationState();
}

class _MiraclePagePresentationState
    extends ConsumerState<MiraclePagePresentation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
    Future.microtask(() {
      _initData();
    });
  }

  String _getName() {
    String text = widget.title;
    List<String> txt = text.split(" ");
    return txt.length == 4 ? txt[3] : txt[4];
  }

  void _initData() {
    ref.read(miracleProvider.notifier).get(widget.parentMenuId!, _getName());
  }

  @override
  Widget build(BuildContext context) {
    final miracle = ref.watch(miracleProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        elevation: 8,
        title: Text(
          _getName(),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: miracle.when(
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, st) => Center(
          child: Text(err.toString()),
        ),
        data: (data) {
          if (data == null || data.isEmpty) {
            return Center(
              child: Text("No data available!"),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 3,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  width: 250,
                                  height: 250,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8), // opsional
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://digio.pgn.co.id/digiomobilebe/static/images/miracles/${data[index].image}',
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.question,
                                          size: 40,
                                        ),
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data[index].name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
