import 'package:flutter/material.dart';

class FieldMapPartialsHome extends StatefulWidget {
  const FieldMapPartialsHome({super.key});

  @override
  State<FieldMapPartialsHome> createState() => _FieldMapPartialsHomeState();
}

class _FieldMapPartialsHomeState extends State<FieldMapPartialsHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init field map");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Field Map"),
      ),
    );
  }
}
