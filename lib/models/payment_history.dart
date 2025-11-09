class PaymentHistory {
  List<Data>? data;
  int? count;

  PaymentHistory({this.data, this.count});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  String? sId;
  int? paymentUid;
  String? paymentFor;
  int? paymentAmount;
  String? paymentDate;

  Data({this.sId, this.paymentUid, this.paymentFor, this.paymentAmount,this.paymentDate});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    paymentUid = json['payment_uid'];
    paymentFor = json['payment_for'];
    paymentAmount = json['payment_amount'];
    paymentDate = json['payment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['payment_uid'] = paymentUid;
    data['payment_for'] = paymentFor;
    data['payment_amount'] = paymentAmount;
    data['payment_date'] = paymentDate;
    return data;
  }
}
