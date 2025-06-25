class ChildResponse {
  ChildResponse({
    required this.data,
    required this.status,
  });
  int? status;
  String? data;

  factory ChildResponse.fromJson(Map<String, dynamic> json) => ChildResponse(
        status: json['status'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        'status': status!,
        'data': data!,
      };
}
