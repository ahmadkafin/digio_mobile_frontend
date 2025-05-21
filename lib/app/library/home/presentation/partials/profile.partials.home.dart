import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}
