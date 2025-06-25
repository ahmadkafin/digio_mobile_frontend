import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/core/utils/styleText.utils.dart';
import 'package:shimmer/shimmer.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Example background image or colors
              Container(
                width: 300,
                height: 420,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/background.jpg',
                    ), // Your background
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Frosted Glass Layer
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  width: 300,
                  height: 420,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withAlpha(25),
                        Colors.white.withAlpha(60),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withAlpha(50),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        offset: Offset(2, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // User avatar and name
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Marline Bettye",
                            style: TextStyle(
                              color: Colors.black.withAlpha(220),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Connecting...",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      // Action button
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person_add),
                        label: Text("Add Member"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withAlpha(240),
                          foregroundColor: Colors.black,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
