import 'package:flutter/material.dart';

class DetailPipeLenPage extends StatelessWidget {
  const DetailPipeLenPage({super.key, required this.dt});
  final String dt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(30, 30, 30, 1),
            foregroundColor: Colors.white,
            stretch: false,
            expandedHeight: 270,
            snap: true,
            floating: true,
            pinned: true,
            elevation: 8,
            title: Text(
              "Asset Summary",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(20, 30, 48, 1),
                          // Color.fromRGBO(36, 59, 85, 1),
                          // Color.fromRGBO(96, 108, 136, 1),
                          Color.fromRGBO(63, 76, 107, 1),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'img/icon-d/Valve-icon.png',
                              scale: 9,
                              color: Color.fromRGBO(255, 170, 0, 1),
                            ),
                            Text(
                              "Pipeline Length",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Image.asset(
                          "img/icon-d/Pipeline-length.png",
                          scale: 5,
                          color: Color.fromRGBO(255, 170, 0, 1),
                        ),
                        Text(
                          "33.288,26 KM",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                        ),
                        Text(
                          dt,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 8,
            itemBuilder: (BuildContext _, int index) {
              return Card(
                elevation: 8,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(20, 30, 48, 1),
                        Color.fromRGBO(36, 59, 85, 1),
                        Color.fromRGBO(63, 76, 107, 1),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'img/icon-d/Valve-icon.png',
                              scale: 8,
                              color: Color.fromRGBO(255, 170, 0, 1),
                            ),
                            Flexible(
                              child: Text(
                                "txt icon icon panjang",
                                maxLines: 5,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Sekian Unit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
