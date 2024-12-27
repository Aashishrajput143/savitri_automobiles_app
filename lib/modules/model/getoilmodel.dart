class GetOilModel {
  String? message;
  Data? data;
  int? statusCode;

  GetOilModel({this.message, this.data, this.statusCode});

  GetOilModel.fromJson(Map<String, dynamic> json) {
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
  List<Docs>? docs;
  bool? hasNextPage;
  bool? hasPrevPage;
  int? limit;
  int? page;
  int? totalDocs;
  int? totalPages;

  Data(
      {this.docs,
      this.hasNextPage,
      this.hasPrevPage,
      this.limit,
      this.page,
      this.totalDocs,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(new Docs.fromJson(v));
      });
    }
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
    limit = json['limit'];
    page = json['page'];
    totalDocs = json['totalDocs'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['totalDocs'] = this.totalDocs;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Docs {
  String? sId;
  String? oilName;
  String? oilType;
  List<Compatibility>? compatibility;
  String? viscosity;
  int? quantity;
  int? reorderLevel;
  String? packagingType;
  int? packagingSize;
  String? manufactureDate;
  String? expiryDate;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? price;

  Docs(
      {this.sId,
      this.oilName,
      this.oilType,
      this.compatibility,
      this.viscosity,
      this.quantity,
      this.reorderLevel,
      this.packagingType,
      this.packagingSize,
      this.manufactureDate,
      this.expiryDate,
      this.status,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.price});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    oilName = json['oilName'];
    oilType = json['oilType'];
    if (json['compatibility'] != null) {
      compatibility = <Compatibility>[];
      json['compatibility'].forEach((v) {
        compatibility!.add(new Compatibility.fromJson(v));
      });
    }
    viscosity = json['viscosity'];
    quantity = json['quantity'];
    reorderLevel = json['reorderLevel'];
    packagingType = json['packagingType'];
    packagingSize = json['packagingSize'];
    manufactureDate = json['manufactureDate'];
    expiryDate = json['expiryDate'];
    status = json['status'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['oilName'] = this.oilName;
    data['oilType'] = this.oilType;
    if (this.compatibility != null) {
      data['compatibility'] =
          this.compatibility!.map((v) => v.toJson()).toList();
    }
    data['viscosity'] = this.viscosity;
    data['quantity'] = this.quantity;
    data['reorderLevel'] = this.reorderLevel;
    data['packagingType'] = this.packagingType;
    data['packagingSize'] = this.packagingSize;
    data['manufactureDate'] = this.manufactureDate;
    data['expiryDate'] = this.expiryDate;
    data['status'] = this.status;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['price'] = this.price;
    return data;
  }
}

class Compatibility {
  String? tractorModel;
  String? tractorBrand;
  String? sId;

  Compatibility({this.tractorModel, this.tractorBrand, this.sId});

  Compatibility.fromJson(Map<String, dynamic> json) {
    tractorModel = json['tractorModel'];
    tractorBrand = json['tractorBrand'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tractorModel'] = this.tractorModel;
    data['tractorBrand'] = this.tractorBrand;
    data['_id'] = this.sId;
    return data;
  }
}
