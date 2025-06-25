import 'package:shared_preferences/shared_preferences.dart';

void activateBiometrics(bool isActive) async {
  final sp = await SharedPreferences.getInstance();
  sp.setBool('isBiometricActive', isActive);
}
