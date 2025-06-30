import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/child/providers/child.providers.dart';
import 'package:myapp/app/library/child/repositories/child.repositories.dart';
import 'package:myapp/app/library/fieldMap/presentation/fieldmap.presentation.dart';
import 'package:myapp/core/utils/endpoint.utils.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class FieldMapPartialsHome extends StatefulHookConsumerWidget {
  const FieldMapPartialsHome({super.key});

  @override
  ConsumerState<FieldMapPartialsHome> createState() =>
      _FieldMapPartialsHomeState();
}

class _FieldMapPartialsHomeState extends ConsumerState<FieldMapPartialsHome> {
  String? cookieInit;

  @override
  void initState() {
    super.initState();
    print("init field map");
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Field map".toUpperCase(),
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        width: deviceSize.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMapCard(
              context: context,
              label: "Open Redspot dan Anomaly",
              imageAsset: 'img/redspot_bg.png',
              url: redspotUrl,
              ref: ref,
            ),
            // _customDivider(deviceSize),
            // _buildMapCard(
            //   context: context,
            //   label: "Open Anomaly",
            //   imageAsset: 'img/anomaly_bg.png',
            //   url: "URL",
            //   ref: ref,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapCard({
    required BuildContext context,
    required String label,
    required String imageAsset,
    required String url,
    required WidgetRef ref,
  }) {
    Size deviceSize = MediaQuery.of(context).size;

    return Expanded(
      flex: 1,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: OpenContainer(
            closedColor: Colors.transparent,
            openColor: Colors.transparent,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            openShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            closedBuilder: (_, VoidCallback openContainer) {
              return GestureDetector(
                onTap: () async {
                  final storageService = ref.read(childStorageServiceProvider);
                  final cookie = await storageService.getCookieData();
                  if (cookie == null) {
                    final res = await ref.read(childProvider.notifier).get();
                    if (!mounted) return;
                    debugPrint("cookie not found!");
                    res.fold(
                      (l) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Cannot open menu, please contact administrator!",
                          ),
                        ),
                      ),
                      (r) async {
                        await storageService.setCookieData(r);
                        if (!mounted) return;
                        setState(() {
                          cookieInit = r.data;
                        });
                        print(r.data);
                        openContainer();
                      },
                    );
                  } else {
                    cookieInit = cookie.data;
                    print(cookieInit);
                    openContainer();
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: deviceSize.width * 0.95,
                      height: deviceSize.height * 0.6,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(30, 30, 30, 1),
                        image: DecorationImage(
                          image: AssetImage(imageAsset),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(32),
                        ),
                        child: Container(
                          width: deviceSize.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.amber,
                          height: deviceSize.height / 14,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                label,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Color.fromRGBO(30, 30, 30, 1),
                                size: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            openBuilder: (_, __) {
              return FieldMapPresentation(
                title: label.replaceAll("Open ", ""),
                url: url,
                cookie: cookieInit,
              );
            },
            transitionType: ContainerTransitionType.fadeThrough,
          ),
        ),
      ),
    );
  }

  Container _customDivider(Size deviceSize) {
    return Container(
      height: 2,
      width: deviceSize.width / 1.1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.blue,
            Colors.purple,
            Colors.transparent,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
