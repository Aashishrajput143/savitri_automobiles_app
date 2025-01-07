class GetServiceGraphModel {
  String? message;
  List<Datagraph>? data;
  int? statusCode;

  GetServiceGraphModel({this.message, this.data, this.statusCode});

  GetServiceGraphModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Datagraph>[];
      json['data'].forEach((v) {
        data!.add(new Datagraph.fromJson(v));
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

class Datagraph {
  int? month;
  int? oilsCount;
  int? sparePartsCount;
  int? year;

  Datagraph({this.month, this.oilsCount, this.sparePartsCount, this.year});

  Datagraph.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    oilsCount = json['oilsCount'];
    sparePartsCount = json['sparePartsCount'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['oilsCount'] = this.oilsCount;
    data['sparePartsCount'] = this.sparePartsCount;
    data['year'] = this.year;
    return data;
  }
}
