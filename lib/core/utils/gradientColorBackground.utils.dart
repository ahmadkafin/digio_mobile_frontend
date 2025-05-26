import 'package:flutter/material.dart';

final Map<String, List<Color>> colorData = {
  'MONEV AIM': [
    Color.fromRGBO(40, 60, 134, 1),
    Color.fromRGBO(69, 162, 71, 1),
  ],
  'Dashboard': [
    Color.fromRGBO(255, 216, 155, 1),
    Color.fromRGBO(25, 84, 123, 1),
  ],
  'Map': [
    Color.fromRGBO(0, 153, 247, 1),
    Color.fromRGBO(241, 23, 18, 1),
  ],
  'Apps': [
    Color.fromRGBO(67, 198, 172, 1),
    Color.fromRGBO(25, 22, 84, 1),
  ],
  'Lainnya': [
    Color.fromRGBO(29, 151, 108, 1),
    Color.fromRGBO(147, 249, 185, 1),
  ],
};

List<Color>? getColorData(String keyString) {
  return colorData[keyString];
}
