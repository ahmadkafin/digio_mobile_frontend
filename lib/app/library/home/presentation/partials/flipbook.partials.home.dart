import 'package:flutter/material.dart';

class FlipBookPartialsHome extends StatefulWidget {
  const FlipBookPartialsHome({super.key});

  @override
  State<FlipBookPartialsHome> createState() => _FlipBookPartialsHomeState();
}

class _FlipBookPartialsHomeState extends State<FlipBookPartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init flip book");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("FlipBook"),
      ),
    );
  }
}
