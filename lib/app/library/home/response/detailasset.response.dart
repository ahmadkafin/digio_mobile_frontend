class DetailAssetResponse {
  DetailAssetResponse({
    required this.no,
    required this.asset,
    required this.owner,
    required this.unit,
  });

  String? asset, owner;
  int? no;
  double? unit;

  factory DetailAssetResponse.fromJson(Map<String, dynamic> json) =>
      DetailAssetResponse(
        no: json['no'],
        asset: json['asset'],
        owner: json['owner'],
        unit: json['unit'].toDouble(),
      );
}
