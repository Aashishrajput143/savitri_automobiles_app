class OilInventoryModel {
  String? message;
  dynamic data;
  int? statusCode;

  OilInventoryModel({this.message, this.data, this.statusCode});

  OilInventoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['data'] = this.data;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
