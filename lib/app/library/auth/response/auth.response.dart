class AuthResponse {
  String? username, name, group, title, token, digioToken, directory;
  int? expires;

  AuthResponse({
    required this.username,
    required this.name,
    required this.group,
    required this.title,
    required this.token,
    required this.digioToken,
    required this.expires,
    required this.directory,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      username: json['username'] as String?,
      name: json['name'] as String?,
      group: json['group'] as String?,
      title: json['title'] as String?,
      token: json['token'] as String?,
      digioToken: json['digioToken'] as String?,
      expires: json['expires'] as int?,
      directory: json['directory'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'name': name,
        'group': group,
        'title': title,
        'token': token,
        'digioToken': digioToken,
        'expires': expires,
        'directory': directory,
      };
}
