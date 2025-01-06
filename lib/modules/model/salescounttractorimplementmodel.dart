class SalesCountTractorImplementModel {
  String? message;
  Data? data;
  int? statusCode;

  SalesCountTractorImplementModel({this.message, this.data, this.statusCode});

  SalesCountTractorImplementModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Data {
  int? equipmentCount;
  int? salesCount;

  Data({this.equipmentCount, this.salesCount});

  Data.fromJson(Map<String, dynamic> json) {
    equipmentCount = json['equipmentCount'];
    salesCount = json['salesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['equipmentCount'] = this.equipmentCount;
    data['salesCount'] = this.salesCount;
    return data;
  }
}
