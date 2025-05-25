class GradeModel {
  List<Data>? data;
  int? count;

  GradeModel({this.data, this.count});

  GradeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) data['data'] = this.data!.map((v) => v.toJson()).toList();
    data['count'] = count;
    return data;
  }
}

class Data {
  String? sId;
  String? title;

  Data({this.sId, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}
