class GetTractorModel {
  String? message;
  Data? data;
  int? statusCode;

  GetTractorModel({this.message, this.data, this.statusCode});

  GetTractorModel.fromJson(Map<String, dynamic> json) {
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
  List<Docstractor>? docs;
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
      docs = <Docstractor>[];
      json['docs'].forEach((v) {
        docs!.add(new Docstractor.fromJson(v));
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

class Docstractor {
  Transmission? transmission;
  String? sId;
  String? modelName;
  String? brandName;
  int? yearOfManufacture;
  String? description;
  String? features;
  String? engineMakeAndType;
  int? horsepower;
  String? engineCapacity;
  int? numberOfCylinders;
  String? coolingSystem;
  String? fuelType;
  int? fuelCapacity;
  int? length;
  int? width;
  int? height;
  int? wheelbase;
  int? maxSpeed;
  int? maximumLiftCapacity;
  String? frontTireSize;
  String? rearTireSize;
  String? hydraulicPumpType;
  int? hydraulicFlowRate;
  int? price;
  int? tax;
  int? discount;
  int? margin;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? quantity;

  Docstractor(
      {this.transmission,
      this.sId,
      this.modelName,
      this.brandName,
      this.yearOfManufacture,
      this.description,
      this.features,
      this.engineMakeAndType,
      this.horsepower,
      this.engineCapacity,
      this.numberOfCylinders,
      this.coolingSystem,
      this.fuelType,
      this.fuelCapacity,
      this.length,
      this.width,
      this.height,
      this.wheelbase,
      this.maxSpeed,
      this.maximumLiftCapacity,
      this.frontTireSize,
      this.rearTireSize,
      this.hydraulicPumpType,
      this.hydraulicFlowRate,
      this.price,
      this.tax,
      this.discount,
      this.margin,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.quantity});

  Docstractor.fromJson(Map<String, dynamic> json) {
    transmission = json['transmission'] != null
        ? new Transmission.fromJson(json['transmission'])
        : null;
    sId = json['_id'];
    modelName = json['modelName'];
    brandName = json['brandName'];
    yearOfManufacture = json['yearOfManufacture'];
    description = json['description'];
    features = json['features'];
    engineMakeAndType = json['engineMakeAndType'];
    horsepower = json['horsepower'];
    engineCapacity = json['engineCapacity'];
    numberOfCylinders = json['numberOfCylinders'];
    coolingSystem = json['coolingSystem'];
    fuelType = json['fuelType'];
    fuelCapacity = json['fuelCapacity'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    wheelbase = json['wheelbase'];
    maxSpeed = json['maxSpeed'];
    maximumLiftCapacity = json['maximumLiftCapacity'];
    frontTireSize = json['frontTireSize'];
    rearTireSize = json['rearTireSize'];
    hydraulicPumpType = json['hydraulicPumpType'];
    hydraulicFlowRate = json['hydraulicFlowRate'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
    margin = json['margin'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transmission != null) {
      data['transmission'] = this.transmission!.toJson();
    }
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    data['brandName'] = this.brandName;
    data['yearOfManufacture'] = this.yearOfManufacture;
    data['description'] = this.description;
    data['features'] = this.features;
    data['engineMakeAndType'] = this.engineMakeAndType;
    data['horsepower'] = this.horsepower;
    data['engineCapacity'] = this.engineCapacity;
    data['numberOfCylinders'] = this.numberOfCylinders;
    data['coolingSystem'] = this.coolingSystem;
    data['fuelType'] = this.fuelType;
    data['fuelCapacity'] = this.fuelCapacity;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['wheelbase'] = this.wheelbase;
    data['maxSpeed'] = this.maxSpeed;
    data['maximumLiftCapacity'] = this.maximumLiftCapacity;
    data['frontTireSize'] = this.frontTireSize;
    data['rearTireSize'] = this.rearTireSize;
    data['hydraulicPumpType'] = this.hydraulicPumpType;
    data['hydraulicFlowRate'] = this.hydraulicFlowRate;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['margin'] = this.margin;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Transmission {
  Pto? pto;

  Transmission({this.pto});

  Transmission.fromJson(Map<String, dynamic> json) {
    pto = json['pto'] != null ? new Pto.fromJson(json['pto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pto != null) {
      data['pto'] = this.pto!.toJson();
    }
    return data;
  }
}

class Pto {
  dynamic speeds;

  Pto({this.speeds});

  Pto.fromJson(Map<String, dynamic> json) {
    if (json['speeds'] != null) {
      speeds = <Null>[];
      json['speeds'].forEach((v) {
        speeds!.add();
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.speeds != null) {
      data['speeds'] = this.speeds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
