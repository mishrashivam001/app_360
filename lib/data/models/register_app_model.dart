// ignore_for_file: unnecessary_new, prefer_collection_literals

class ResgisterApp {
  bool? success;
  RegisterAppData? data;

  ResgisterApp({this.success, this.data});

  ResgisterApp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? RegisterAppData.fromJson(json['data']) : null;
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

class RegisterAppData {
  int? id;
  String? uuid;
  int? projectId;
  String? name;
  String? firebaseToken;
  String? type;
  String? secret;

  RegisterAppData(
      {this.id,
      this.uuid,
      this.projectId,
      this.name,
      this.firebaseToken,
      this.type,
      this.secret});

  RegisterAppData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    projectId = json['ProjectId'];
    name = json['Name'];
    firebaseToken = json['FirebaseToken'];
    type = json['type'];
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['uuid'] = uuid;
    data['ProjectId'] = projectId;
    data['Name'] = name;
    data['FirebaseToken'] = firebaseToken;
    data['type'] = type;
    data['secret'] = secret;
    return data;
  }
}
