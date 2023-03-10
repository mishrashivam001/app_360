class RateListResponse {
  List<RateListData>? data;
  String? status;

  RateListResponse({this.data, this.status});

  RateListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RateListData>[];
      json['data'].forEach((v) {
        data!.add(RateListData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class RateListData {
  String? rate;
  String? symbol;
  String? priceChange24h;
  String? priceChangePercentage24h;
  String? lastRemoteUpdate;
  String? img;
  String? marketCap;

  RateListData(
      {this.rate,
      this.symbol,
      this.priceChange24h,
      this.priceChangePercentage24h,
      this.lastRemoteUpdate,
      this.img,
      this.marketCap});

  RateListData.fromJson(Map<String, dynamic> json) {
    rate = json['Rate'];
    symbol = json['Symbol'];
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
    lastRemoteUpdate = json['lastRemoteUpdate'];
    img = json['img'];
    marketCap = json['market_cap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Rate'] = rate;
    data['Symbol'] = symbol;
    data['price_change_24h'] = priceChange24h;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    data['lastRemoteUpdate'] = lastRemoteUpdate;
    data['img'] = img;
    data['market_cap'] = marketCap;
    return data;
  }
}
// {
//   "data": [
//     {
//       "Rate": "24067.00",
//       "Symbol": "btc\/usd",
//       "price_change_24h": "-779.52",
//       "price_change_percentage_24h": "-3.14",
//       "lastRemoteUpdate": "2023-02-22 06:41:00",
//       "img": "https:\/\/i.imgur.com\/X603dMm.png",
//       "market_cap": "464536405689"
//     }
//   ],
//   "status": "Success"
// }
