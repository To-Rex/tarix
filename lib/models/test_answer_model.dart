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
  String? duration;
  int? ball;
  double? ballPercent;
  String? createdAt;
  int? questionsCount;
  int? answersCount;

  TestAnswerData({this.sId, this.test, this.duration, this.ball, this.ballPercent, this.createdAt, this.questionsCount, this.answersCount});

  TestAnswerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    test = json['test'] != null ? TestInfo.fromJson(json['test']) : null;
    duration = json['duration'];
    ball = json['ball'];
    ballPercent = json['ball_percent']?.toDouble();
    createdAt = json['createdAt'];
    questionsCount = json['questions_count'];
    answersCount = json['answers_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['test'] = test?.toJson();
    data['duration'] = duration;
    data['ball'] = ball;
    data['ball_percent'] = ballPercent;
    data['createdAt'] = createdAt;
    data['questions_count'] = questionsCount;
    data['answers_count'] = answersCount;
    return data;
  }
}

class TestInfo {
  String? sId;
  String? title;
  int? minutes;
  String? languageSegment;
  String? createdAt;

  TestInfo({this.sId, this.title, this.minutes, this.languageSegment, this.createdAt});

  TestInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    minutes = json['minutes'];
    languageSegment = json['language_segment'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['minutes'] = minutes;
    data['language_segment'] = languageSegment;
    data['createdAt'] = createdAt;
    return data;
  }
}
