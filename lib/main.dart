import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';
import 'package:myapp/app/library/home/presentation/page/home.page.home.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Digio Mobile", home: HomePageHome());
  }
}
