class CoinsResponse {
  bool? success;
  CoinsPostData? data;

  CoinsResponse({this.success, this.data});

  CoinsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CoinsPostData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CoinsPostData {
  int? id;
  int? mobileAppId;
  String? symbol;
  String? count;

  CoinsPostData({this.id, this.mobileAppId, this.symbol, this.count});

  CoinsPostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileAppId = json['MobileAppId'];
    symbol = json['Symbol'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['MobileAppId'] = mobileAppId;
    data['Symbol'] = symbol;
    data['Count'] = count;
    return data;
  }
}
