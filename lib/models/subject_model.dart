class SubjectModel {
  List<Data>? data;
  int? count;

  SubjectModel({this.data, this.count});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) data = <Data>[];json['data'].forEach((v) {data!.add(Data.fromJson(v));});
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
  String? photo;
  String? title;
  String? subtitle;
  String? type;
  bool? withGrade;

  Data({this.sId, this.photo, this.title, this.subtitle, this.type, this.withGrade});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    photo = json['photo'];
    title = json['title'];
    subtitle = json['subtitle'];
    type = json['type'];
    withGrade = json['with_grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['photo'] = photo;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['type'] = type;
    data['with_grade'] = withGrade;
    return data;
  }
}
