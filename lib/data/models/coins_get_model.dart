class CoinsGetResponse {
  bool? success;
  GetCoinsData? data;

  CoinsGetResponse({this.success, this.data});

  CoinsGetResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? GetCoinsData.fromJson(json['data']) : null;
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

class GetCoinsData {
  List<Items>? items;
  Links? lLinks;
  Meta? mMeta;

  GetCoinsData({this.items, this.lLinks, this.mMeta});

  GetCoinsData.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? Meta.fromJson(json['_meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    if (mMeta != null) {
      data['_meta'] = mMeta!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  int? mobileAppId;
  String? symbol;
  int? count;

  Items({this.id, this.mobileAppId, this.symbol, this.count});

  Items.fromJson(Map<String, dynamic> json) {
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

class Links {
  Self? self;
  Self? first;
  Self? last;

  Links({this.self, this.first, this.last});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    first = json['first'] != null ? Self.fromJson(json['first']) : null;
    last = json['last'] != null ? Self.fromJson(json['last']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.toJson();
    }
    if (first != null) {
      data['first'] = first!.toJson();
    }
    if (last != null) {
      data['last'] = last!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class Meta {
  int? totalCount;
  int? pageCount;
  int? currentPage;
  int? perPage;

  Meta({this.totalCount, this.pageCount, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['pageCount'] = pageCount;
    data['currentPage'] = currentPage;
    data['perPage'] = perPage;
    return data;
  }
}
