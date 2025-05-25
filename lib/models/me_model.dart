class MeModel {
  Data? data;

  MeModel({this.data});

  MeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  String? fullName;
  String? photo;
  String? googleId;

  Data({this.sId, this.email, this.fullName, this.photo, this.googleId});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    fullName = json['full_name'];
    photo = json['photo'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['full_name'] = fullName;
    data['photo'] = photo;
    data['google_id'] = googleId;
    return data;
  }
}
