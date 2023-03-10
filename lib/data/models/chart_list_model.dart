class ChartListResponse {
  String? errors;
  List<ChartListData>? data;
  String? status;

  ChartListResponse({this.errors, this.data, this.status});

  ChartListResponse.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    if (json['data'] != null) {
      data = <ChartListData>[];
      json['data'].forEach((v) {
        data!.add(ChartListData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ChartListData {
  int? i0;
  double? d1;

  ChartListData({this.i0, this.d1});

  ChartListData.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    d1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['0'] = i0;
    data['1'] = d1;
    return data;
  }
}
// {
//   "errors": "Missing mandatory parameter",
//   "data": [
//     {
//       "0": 1676959383075,
//       "1": 20742.882912414534
//     },
//     {
//       "0": 1676962928843,
//       "1": 20770.713653538238
//     },
//     {
//       "0": 1676966471689,
//       "1": 20787.973709955346
//     }
//   ],
//   "status": "Success"
// }