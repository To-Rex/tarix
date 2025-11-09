/*
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
*/












class MeModel {
  Data? data;

  MeModel({this.data});

  MeModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (data != null) result['data'] = data!.toJson();
    return result;
  }
}

class Data {
  Dollar? dollar;
  bool? isNew;
  Doc? doc;
  int? appPrice;

  Data({this.dollar, this.isNew, this.doc, this.appPrice});

  Data.fromJson(Map<String, dynamic> json) {
    dollar = json[r'$__'] != null ? Dollar.fromJson(json[r'$__']) : null;
    isNew = json['$isNew'];
    doc = json['_doc'] != null ? Doc.fromJson(json['_doc']) : null;
    appPrice = json['app_price']; // ✅ bu yerda parse qilinadi
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    //if (dollar != null) result['$__'] = dollar!.toJson();
    if (dollar != null) result[r'$__'] = dollar!.toJson();

    result['$isNew'] = isNew;
    if (doc != null) result['_doc'] = doc!.toJson();
    result['app_price'] = appPrice; // ✅ serialize qilinadi
    return result;
  }
}

class Doc {
  String? id;
  String? email;
  String? fullName;
  String? photo;
  String? appleId;
  bool? paid;
  String? googleId;

  Doc({this.id, this.email, this.fullName, this.photo, this.appleId, this.googleId});

  Doc.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    fullName = json['full_name'];
    photo = json['photo'];
    appleId = json['apple_id'];
    paid = json['paid'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['_id'] = id;
    result['email'] = email;
    result['full_name'] = fullName;
    result['photo'] = photo;
    result['apple_id'] = appleId;
    result['paid'] = paid;
    result['google_id'] = googleId;
    return result;
  }
}

/// $__
class Dollar {
  ActivePaths? activePaths;
  bool? skipId;
  Selected? selected;
  bool? exclude;

  Dollar({this.activePaths, this.skipId, this.selected, this.exclude});

  Dollar.fromJson(Map<String, dynamic> json) {
    activePaths = json['activePaths'] != null
        ? ActivePaths.fromJson(json['activePaths'])
        : null;
    skipId = json['skipId'];
    selected = json['selected'] != null
        ? Selected.fromJson(json['selected'])
        : null;
    exclude = json['exclude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (activePaths != null) result['activePaths'] = activePaths!.toJson();
    result['skipId'] = skipId;
    if (selected != null) result['selected'] = selected!.toJson();
    result['exclude'] = exclude;
    return result;
  }
}

/// activePaths
class ActivePaths {
  Paths? paths;
  States? states;

  ActivePaths({this.paths, this.states});

  ActivePaths.fromJson(Map<String, dynamic> json) {
    paths = json['paths'] != null ? Paths.fromJson(json['paths']) : null;
    states = json['states'] != null ? States.fromJson(json['states']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    if (paths != null) result['paths'] = paths!.toJson();
    if (states != null) result['states'] = states!.toJson();
    return result;
  }
}

class Paths {
  String? email;
  String? id;
  String? fullName;
  String? photo;
  String? appleId;
  String? googleId;

  Paths({this.email, this.id, this.fullName, this.photo, this.appleId, this.googleId});

  Paths.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['_id'];
    fullName = json['full_name'];
    photo = json['photo'];
    appleId = json['apple_id'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['email'] = email;
    result['_id'] = id;
    result['full_name'] = fullName;
    result['photo'] = photo;
    result['apple_id'] = appleId;
    result['google_id'] = googleId;
    return result;
  }
}

class States {
  Map<String, dynamic>? require;
  Init? init;

  States({this.require, this.init});

  States.fromJson(Map<String, dynamic> json) {
    require = json['require'];
    init = json['init'] != null ? Init.fromJson(json['init']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['require'] = require;
    if (init != null) result['init'] = init!.toJson();
    return result;
  }
}

class Init {
  bool? id;
  bool? email;
  bool? fullName;
  bool? photo;
  bool? appleId;
  bool? googleId;

  Init({this.id, this.email, this.fullName, this.photo, this.appleId, this.googleId});

  Init.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    fullName = json['full_name'];
    photo = json['photo'];
    appleId = json['apple_id'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['_id'] = id;
    result['email'] = email;
    result['full_name'] = fullName;
    result['photo'] = photo;
    result['apple_id'] = appleId;
    result['google_id'] = googleId;
    return result;
  }
}

class Selected {
  int? fullName;
  int? email;
  int? photo;
  int? googleId;
  int? appleId;

  Selected({this.fullName, this.email, this.photo, this.googleId, this.appleId});

  Selected.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    photo = json['photo'];
    googleId = json['google_id'];
    appleId = json['apple_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result['full_name'] = fullName;
    result['email'] = email;
    result['photo'] = photo;
    result['google_id'] = googleId;
    result['apple_id'] = appleId;
    return result;
  }
}
