class ServiceCountModel {
  String? message;
  Data? data;
  int? statusCode;

  ServiceCountModel({this.message, this.data, this.statusCode});

  ServiceCountModel.fromJson(Map<String, dynamic> json) {
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
  int? sparePartsCount;
  int? oilCount;
  int? serviceCount;

  Data({this.sparePartsCount, this.oilCount, this.serviceCount});

  Data.fromJson(Map<String, dynamic> json) {
    sparePartsCount = json['sparePartsCount'];
    oilCount = json['oilCount'];
    serviceCount = json['serviceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sparePartsCount'] = this.sparePartsCount;
    data['oilCount'] = this.oilCount;
    data['serviceCount'] = this.serviceCount;
    return data;
  }
}
