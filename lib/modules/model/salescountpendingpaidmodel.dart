class SalesCountPendingPaidModel {
  String? message;
  List<Data>? data;
  int? statusCode;

  SalesCountPendingPaidModel({this.message, this.data, this.statusCode});

  SalesCountPendingPaidModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? count;
  String? status;

  Data({this.count, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}
