import 'package:flutter/material.dart';

class AppsAboutInfoPage extends StatelessWidget {
  const AppsAboutInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                width: deviceSize.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tentang Digio Mobile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Sekilas info tentang aplikasi GIS andalan anda.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.topCenter,
                width: deviceSize.width,
                color: Colors.white,
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AppsAboutInfoPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.phone_android,
                        color: Color.fromRGBO(255, 170, 0, 1),
                      ),
                      title: Text(
                        "Aplikasi Digio Mobile",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      dense: true,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.description,
                        color: Color.fromRGBO(255, 170, 0, 1),
                      ),
                      title: Text(
                        "Syarat & Ketentuan",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      dense: true,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.shield,
                        color: Color.fromRGBO(255, 170, 0, 1),
                      ),
                      title: Text(
                        "Kebijakan Keamanan",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      dense: true,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
