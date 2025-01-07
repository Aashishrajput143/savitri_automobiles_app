class SalesGraphModel {
  String? message;
  List<DataSalesGraph>? data;
  int? statusCode;

  SalesGraphModel({this.message, this.data, this.statusCode});

  SalesGraphModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DataSalesGraph>[];
      json['data'].forEach((v) {
        data!.add(new DataSalesGraph.fromJson(v));
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

class DataSalesGraph {
  int? month;
  int? tractorCount;
  int? equipmentCount;
  int? year;

  DataSalesGraph(
      {this.month, this.tractorCount, this.equipmentCount, this.year});

  DataSalesGraph.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    tractorCount = json['tractorCount'];
    equipmentCount = json['equipmentCount'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['tractorCount'] = this.tractorCount;
    data['equipmentCount'] = this.equipmentCount;
    data['year'] = this.year;
    return data;
  }
}
