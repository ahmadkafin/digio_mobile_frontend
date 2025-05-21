import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';
import 'package:myapp/app/library/home/presentation/widget/bottomsheetmenu.widget.home.dart';

class MenuWidgetHome extends StatelessWidget {
  const MenuWidgetHome({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        width: deviceSize.width,
        height: deviceSize.height / 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.home_repair_service,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "MONEV AIM",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.keyboard,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.map,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Map",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.laptop,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Apps",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext ctx) {
                    return BottomSheetMenWidgetHome(deviceSize: deviceSize);
                  },
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.apps_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Lainnya",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
