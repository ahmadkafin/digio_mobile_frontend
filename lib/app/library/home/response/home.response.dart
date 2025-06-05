class HomeResponse {
  HomeResponse({
    required this.name,
    required this.icon,
    required this.value,
    required this.metrics,
  });

  String? name, icon, metrics, value;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        name: json['name'],
        icon: json['icon'],
        value: json['value'],
        metrics: json['metrics'],
      );
}
