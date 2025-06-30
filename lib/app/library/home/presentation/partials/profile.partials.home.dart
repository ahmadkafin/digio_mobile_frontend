import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app/library/auth/providers/auth.providers.dart';
import 'package:myapp/app/library/info/presentation/page/appsabout.info.page.dart';
import 'package:myapp/core/utils/activateBiometrics.utils.dart';
import 'package:myapp/core/utils/styleText.utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePartialsHome extends StatefulHookConsumerWidget {
  const ProfilePartialsHome({super.key});

  @override
  ConsumerState<ProfilePartialsHome> createState() =>
      _ProfilePartialsHomeState();
}

class _ProfilePartialsHomeState extends ConsumerState<ProfilePartialsHome> {
  Map<String, dynamic>? _user;
  final _storage = const FlutterSecureStorage();
  bool isActiveBio = false;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _isActiveBiometrics();
  }

  Future<void> _loadUser() async {
    final jsonStr = await _storage.read(key: 'authUserKey');
    if (jsonStr != null) {
      try {
        final jsonMap = jsonDecode(jsonStr);
        setState(() {
          _user = jsonMap;
        });
      } catch (e) {
        debugPrint("Failed to decode user JSON: $e");
      }
    }
  }

  Future<void> _isActiveBiometrics() async {
    final sp = await SharedPreferences.getInstance();
    isActiveBio = sp.getBool('isBiometricActive') ?? false;
  }

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final String name = _user?['name'] ?? 'Name';
    final String username = _user?['group'] ?? 'Group';
    final String title = _user?['title'] ?? 'Title';

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 80),
        color: Colors.white,
        child: Column(
          children: [
            _buildUserHeader(name, username, title, deviceSize),
            const SizedBox(height: 20),
            _buildMenuList(context),
            const Spacer(),
            _buildLogout(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(String name, String group, String title, Size size) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(20, 30, 48, 1),
              Color.fromRGBO(63, 76, 107, 1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: 100,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(Icons.person, size: 30),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  group,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Expanded(
      flex: 4,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ListTile(
          //   leading: const Icon(
          //     Icons.person_2,
          //     size: 30,
          //     color: Color.fromRGBO(255, 170, 0, 1),
          //   ),
          //   title: const Text(
          //     "Profile Details",
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.black,
          //     ),
          //   ),
          //   subtitle: const Text("View your account informations"),
          //   dense: true,
          // ),
          // const Divider(thickness: 0.5),
          OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            openColor: Colors.transparent,
            closedColor: Colors.transparent,
            closedElevation: 0,
            openBuilder: (context, _) => const AppsAboutInfoPage(),
            closedBuilder: (context, openContainer) {
              return ListTile(
                onTap: openContainer,
                leading: const Icon(
                  Icons.info,
                  size: 30,
                  color: Color.fromRGBO(255, 170, 0, 1),
                ),
                title: Text(
                  "Application Info",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "Find about this applications",
                  style: TextStyle(
                    fontFamily: fontFamily,
                  ),
                ),
                dense: true,
              );
            },
          ),
          const Divider(thickness: 0.5),
          ListTile(
            leading: const Icon(
              Icons.fingerprint,
              size: 30,
              color: Color.fromRGBO(255, 170, 0, 1),
            ),
            title: Text(
              "Activate Biometrics",
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              "Activate Biometrics to quick sign in",
              style: TextStyle(
                fontFamily: fontFamily,
              ),
            ),
            dense: true,
            trailing: Switch(
              activeColor: Color.fromRGBO(255, 170, 0, 1),
              activeTrackColor: Color.fromRGBO(20, 30, 48, 1),
              value: isActiveBio!,
              onChanged: (bool isActive) {
                setState(() {
                  isActiveBio = isActive;
                });
                activateBiometrics(isActive);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogout() {
    return GestureDetector(
      onTap: _logout,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          "Logout".toUpperCase(),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
