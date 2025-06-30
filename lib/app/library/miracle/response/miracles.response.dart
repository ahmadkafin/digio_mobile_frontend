class MiraclesResponse {
  MiraclesResponse({
    required this.name,
    required this.url,
    required this.x,
    required this.y,
    required this.level,
    required this.groupsMiracle,
    required this.image,
    required this.hasChild,
    required this.isActive,
    required this.isRevoked,
  });

  String? name, url, x, y, groupsMiracle, image;
  bool? hasChild, isActive, isRevoked;
  int? level;

  factory MiraclesResponse.fromJson(Map<String, dynamic> json) =>
      MiraclesResponse(
        name: json['name'],
        url: json['url'],
        x: json['x'],
        y: json['y'],
        level: json['level'],
        groupsMiracle: json['groupsMiracle'],
        image: json['image'],
        hasChild: json['hasChild'],
        isActive: json['isActive'],
        isRevoked: json['isRevoked'],
      );
}
