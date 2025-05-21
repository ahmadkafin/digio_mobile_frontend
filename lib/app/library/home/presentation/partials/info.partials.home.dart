import 'package:flutter/material.dart';

class InfoPartialsHome extends StatefulWidget {
  const InfoPartialsHome({super.key});

  @override
  State<InfoPartialsHome> createState() => _InfoPartialsHomeState();
}

class _InfoPartialsHomeState extends State<InfoPartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init info page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Info"),
      ),
    );
  }
}
