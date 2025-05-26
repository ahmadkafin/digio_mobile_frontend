class MenuResponse {
  MenuResponse({
    required this.menuid,
    required this.parrentid,
    required this.name,
    required this.label,
    required this.url,
    required this.contenttype,
    required this.querystring,
    required this.icon,
    required this.icontype,
    required this.haschild,
    required this.enable,
    required this.menuorder,
    required this.filterWilayah,
    required this.iconFlt,
  });

  String? menuid,
      parrentid,
      name,
      label,
      url,
      contenttype,
      querystring,
      icon,
      icontype,
      iconFlt;
  bool? haschild, enable;
  int? menuorder, filterWilayah;

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        menuid: json['menuid'],
        parrentid: json['parrentid'],
        name: json['name'],
        label: json['label'],
        url: json['url'],
        contenttype: json['contenttype'],
        querystring: json['querystring'],
        icon: json['icon'],
        icontype: json['icontype'],
        haschild: json['haschild'],
        enable: json['enable'],
        menuorder: json['menuorder'],
        filterWilayah: json['filterWilayah'],
        iconFlt: json['icon_flt'],
      );

  Map<String, dynamic> toJson() => {
        'menuid': menuid,
        'parrentid': parrentid,
        'name': name,
        'label': label,
        'url': url,
        'contenttype': contenttype,
        'querystring': querystring,
        'icon': icon,
        'icontype': icontype,
        'haschild': haschild,
        'enable': enable,
        'menuorder': menuorder,
        'filterWilayah': filterWilayah,
        'icon_flt': iconFlt,
      };
}
