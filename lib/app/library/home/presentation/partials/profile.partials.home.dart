import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/library/info/presentation/page/appsabout.info.page.dart';

class ProfilePartialsHome extends StatefulWidget {
  const ProfilePartialsHome({super.key});

  @override
  State<ProfilePartialsHome> createState() => _ProfilePartialsHomeState();
}

class _ProfilePartialsHomeState extends State<ProfilePartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("start init profile");
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 80),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.amber,
                width: deviceSize.width,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(20, 30, 48, 1),
                          Color.fromRGBO(63, 76, 107, 1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "UserName",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: deviceSize.width,
                // color: Colors.red,
                // decoration: BoxDecoration(
                //   color: Color.fromRGBO(30, 30, 30, 1),
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(15),
                //     topRight: Radius.circular(15),
                //   ),
                // ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person_2,
                        size: 30,
                        color: Color.fromRGBO(255, 170, 0, 1),
                      ),
                      title: Text(
                        "Profile Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text("View your account informations"),
                      dense: true,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      openBuilder: (context, action) {
                        return AppsAboutInfoPage();
                      },
                      closedBuilder: (
                        BuildContext _,
                        VoidCallback opencontainer,
                      ) {
                        return ListTile(
                          onTap: opencontainer,
                          leading: Icon(
                            Icons.info,
                            size: 30,
                            color: Color.fromRGBO(255, 170, 0, 1),
                          ),
                          title: Text(
                            "Application Info",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text("Find about this applications"),
                          dense: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Logout".toUpperCase(),
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
