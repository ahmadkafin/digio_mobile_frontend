import 'dart:convert';

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Token tidak valid!');
  }

  final payload = _decodeBase64String(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('Payload bukan berbentuk Map!');
  }

  return payloadMap;
}

String _decodeBase64String(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Base64 URL tidak valid');
  }
  return utf8.decode(base64Url.decode(output));
}
