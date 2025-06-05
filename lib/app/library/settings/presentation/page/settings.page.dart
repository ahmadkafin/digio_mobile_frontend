import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Settings"),
            primary: true,
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text("settings"),
            ),
          ),
        ],
      ),
    );
  }
}
