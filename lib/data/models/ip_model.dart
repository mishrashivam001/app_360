class IpResponse {
  bool? success;
  IpData? data;
  String? error;

  IpResponse({this.success, this.data, this.error});

  IpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'] != null ? IpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (error != null) {
      data['error'] = error;
    }

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class IpData {
  int? id;
  String? name;
  String? iSO2;
  String? iSO3;
  int? prefix;
  String? flag;

  IpData({this.id, this.name, this.iSO2, this.iSO3, this.prefix, this.flag});

  IpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    iSO2 = json['ISO2'];
    iSO3 = json['ISO3'];
    prefix = json['Prefix'];
    flag = json['Flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['ISO2'] = iSO2;
    data['ISO3'] = iSO3;
    data['Prefix'] = prefix;
    data['Flag'] = flag;
    return data;
  }
}
