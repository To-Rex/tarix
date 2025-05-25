class QuizModel {
  Data? data;
  int? count;

  QuizModel({this.data, this.count});

  QuizModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  List<DataS>? data;
  QuizInfo? quizInfo;

  Data({this.data, this.quizInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataS>[];
      json['data'].forEach((v) {
        data!.add(DataS.fromJson(v));
      });
    }
    quizInfo = json['quiz_info'] != null
        ? QuizInfo.fromJson(json['quiz_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (quizInfo != null) {
      data['quiz_info'] = quizInfo!.toJson();
    }
    return data;
  }
}

class DataS {
  String? sId;
  String? question;
  String? answer;

  DataS({this.sId, this.question, this.answer});

  DataS.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}

class QuizInfo {
  String? sId;
  int? freeQuestionLimit;
  int? price;
  String? grade;
  bool? paid;

  QuizInfo(
      {this.sId, this.freeQuestionLimit, this.price, this.grade, this.paid});

  QuizInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    freeQuestionLimit = json['free_question_limit'];
    price = json['price'];
    grade = json['grade'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['free_question_limit'] = freeQuestionLimit;
    data['price'] = price;
    data['grade'] = grade;
    data['paid'] = paid;
    return data;
  }
}
