class TestListModel {
  List<TestData>? data;
  int? count;

  TestListModel({this.data, this.count});

  TestListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TestData>[];
      json['data'].forEach((v) {
        data!.add(TestData.fromJson(v));
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

class TestData {
  String? sId;
  String? title;
  int? questionsCount;
  int? minutes;
  bool? isFree;
  String? languageSegment;
  String? subjectCategory;

  TestData({this.sId, this.title, this.questionsCount, this.minutes, this.isFree, this.languageSegment, this.subjectCategory});

  TestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    questionsCount = json['questions_count'];
    minutes = json['minutes'];
    isFree = json['is_free'];
    languageSegment = json['language_segment'];
    subjectCategory = json['subject_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['questions_count'] = questionsCount;
    data['minutes'] = minutes;
    data['is_free'] = isFree;
    data['language_segment'] = languageSegment;
    data['subject_category'] = subjectCategory;
    return data;
  }
}
