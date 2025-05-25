import 'dart:ffi';

class PresentationModel {
  List<Data>? data;
  int? count;

  PresentationModel({this.data, this.count});

  PresentationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  String? file;
  String? name;
  String? size;
  String? mimetype;
  bool? isFree;
  int? price;

  Data({this.sId, this.file, this.name, this.size, this.mimetype});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    file = json['file'];
    name = json['name'];
    size = json['size'];
    mimetype = json['mimetype'];
    isFree = json['is_free'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['file'] = file;
    data['name'] = name;
    data['size'] = size;
    data['mimetype'] = mimetype;
    data['isFree'] = isFree;
    data['price'] = price;
    return data;
  }
}
