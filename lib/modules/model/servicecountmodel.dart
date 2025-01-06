class ServiceCountModel {
  String? message;
  List<dynamic>? data;
  int? statusCode;

  ServiceCountModel({this.message, this.data, this.statusCode});

  ServiceCountModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add(null);
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
