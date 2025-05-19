import 'package:flutter/material.dart';
import 'package:myapp/app/library/auth/presentation/page/login.page.auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Digio Mobile", home: LoginPageAuth());
  }
}
