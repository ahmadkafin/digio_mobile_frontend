class AuthRequest {
  String? username, password, directory;

  AuthRequest({
    required this.username,
    required this.password,
    required this.directory,
  });

  factory AuthRequest.fromJson(Map<String, String> json) => AuthRequest(
        username: json['username'],
        password: json['password'],
        directory: json['directory'],
      );

  Map<String, String> toJson() => {
        "username": username!,
        "password": password!,
        "directory": directory!,
      };
}
