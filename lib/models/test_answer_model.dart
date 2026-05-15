class TestAnswerListModel {
  List<TestAnswerData>? data;
  int? count;

  TestAnswerListModel({this.data, this.count});

  TestAnswerListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TestAnswerData>[];
      json['data'].forEach((v) {
        data!.add(TestAnswerData.fromJson(v));
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

class TestAnswerData {
  String? sId;
  TestInfo? test;
  int? ball;
  double? ballPercent;

  TestAnswerData({this.sId, this.test, this.ball, this.ballPercent});

  TestAnswerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    test = json['test'] != null ? TestInfo.fromJson(json['test']) : null;
    ball = json['ball'];
    ballPercent = json['ball_percent']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['test'] = test?.toJson();
    data['ball'] = ball;
    data['ball_percent'] = ballPercent;
    return data;
  }
}

class TestInfo {
  String? sId;
  String? title;
  int? minutes;
  String? languageSegment;

  TestInfo({this.sId, this.title, this.minutes, this.languageSegment});

  TestInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    minutes = json['minutes'];
    languageSegment = json['language_segment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['minutes'] = minutes;
    data['language_segment'] = languageSegment;
    return data;
  }
}
