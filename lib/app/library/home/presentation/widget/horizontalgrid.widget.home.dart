import 'package:flutter/material.dart';
import 'package:myapp/app/library/home/response/home.response.dart';

class HorizontalGridHeaderWidgetHome extends StatelessWidget {
  const HorizontalGridHeaderWidgetHome({
    super.key,
    required this.deviceSize,
    required this.data,
  });

  final Size deviceSize;
  final List<HomeResponse> data;

  @override
  Widget build(BuildContext context) {
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
                return Container(
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
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${data[index].value!} ${data[index].metrics!}",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 170, 0, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
}
