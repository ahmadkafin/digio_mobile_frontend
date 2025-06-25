class PanjangPipaResponse {
  PanjangPipaResponse({
    required this.tahun,
    required this.panjang,
  });

  String? tahun;
  double? panjang;

  factory PanjangPipaResponse.fromJson(Map<String, dynamic> json) =>
      PanjangPipaResponse(
        tahun: json['tahun'],
        panjang: json['panjang'].toDouble(),
      );
}
