import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/home/providers/detailasset.providers.dart';
import 'package:myapp/app/library/home/response/detailasset.response.dart';
import 'package:myapp/app/library/home/response/home.response.dart';
import 'package:myapp/core/utils/styleText.utils.dart';

class HorizontalGridHeaderWidgetHome extends HookConsumerWidget {
  const HorizontalGridHeaderWidgetHome({
    super.key,
    required this.deviceSize,
    required this.data,
    required this.token,
  });

  final Size deviceSize;
  final String token;
  final List<HomeResponse> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String nm = data[index].name! == 'Pipeline Length'
                    ? 'pipa'
                    : data[index].name!;
                return GestureDetector(
                  onTap: () => ref
                      .read(detailAssetProviders.notifier)
                      .get(token, nm)
                      .then(
                        (res) => res.fold(
                          (l) => null,
                          (r) => showStickyFlexibleBottomSheet(
                            context: context,
                            minHeight: 0,
                            initHeight: 0.5,
                            maxHeight: 0.8,
                            headerHeight: 200,
                            bottomSheetColor: Colors.transparent,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            headerBuilder: (BuildContext _, double offset) {
                              return _header(data[index]);
                            },
                            bodyBuilder: (BuildContext _, double offset) {
                              return _body(r, data[index]);
                            },
                          ),
                        ),
                      ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.bottomRight,
                        scale: data[index].name! == 'Pipeline Length' ? 12 : 6,
                        colorFilter: ColorFilter.mode(
                          Color.fromRGBO(255, 170, 0, 1),
                          BlendMode.srcIn,
                        ),
                        image: AssetImage(
                          'img/icon-d/${data[index].icon!}',
                        ),
                      ),
                      color: Color.fromRGBO(30, 30, 30, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].name!,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${data[index].value!} ${data[index].metrics!}",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: Color.fromRGBO(255, 170, 0, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }

  SliverChildListDelegate _body(
      List<DetailAssetResponse> resp, HomeResponse data) {
    return SliverChildListDelegate([
      Container(
        height: deviceSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 56, 56, 56),
              const Color.fromARGB(255, 56, 56, 56),
              // Colors.black,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                resp[index].owner!,
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                _formatUnit(data, resp, index),
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: Colors.white,
                ),
              ),
            );
          },
          itemCount: resp.length,
        ),
      ),
    ]);
  }

  String _formatUnit(
      HomeResponse data, List<DetailAssetResponse> resp, int index) {
    if (data.name == 'Pipeline Length') {
      return "${resp[index].unit!} KM";
    } else {
      return "${resp[index].unit!.toInt()} Unit";
    }
  }

  Widget _header(HomeResponse data) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            const Color.fromARGB(255, 56, 56, 56),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 5,
            width: 100,
            color: Colors.amber,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              data.name!.toUpperCase(),
              style: TextStyle(
                fontFamily: fontFamily,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'img/icon-d/${data.icon!}',
              scale: data.name! == 'Pipeline Length' ? 9 : 4,
              color: Colors.amber,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              '${data.value!} ${data.metrics!}',
              style: TextStyle(
                fontFamily: fontFamily,
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
