import 'dart:convert';

class VillageList {
  String dcode;
  String bcode;
  String pvcode;
  String pvname;
  String pvname_ta;

  VillageList({this.dcode, this.bcode, this.pvcode, this.pvname, this.pvname_ta});

  factory VillageList.fromJson(Map<String, dynamic> json) => VillageList (
    dcode: json["dcode"],
    bcode: json["bcode"],
    pvcode: json["pvcode"],
    pvname: json["pvname"],
    pvname_ta: json["pvname_ta"],
  );



  Map<String, dynamic> toJson() => {
    "dcode": dcode,
    "bcode": bcode,
    "pvcode": pvcode,
    "pvname": pvname,
    "pvname_ta": pvname_ta,
  };
}