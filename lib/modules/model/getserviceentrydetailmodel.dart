class GetServiceEntryDetailModel {
  String? message;
  Data? data;
  int? statusCode;

  GetServiceEntryDetailModel({this.message, this.data, this.statusCode});

  GetServiceEntryDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  Tractor? tractor;
  String? customerName;
  String? customerContact;
  String? customerAddress;
  String? serviceType;
  String? serviceDescription;
  List<SpareParts>? spareParts;
  List<Oils>? oils;
  int? totalPartsCost;
  int? totalCost;
  int? serviceCost;
  String? paymentStatus;
  int? paidAmount;
  int? dueAmount;
  String? paymentMethod;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? oilsCost;

  Data(
      {this.sId,
      this.tractor,
      this.customerName,
      this.customerContact,
      this.customerAddress,
      this.serviceType,
      this.serviceDescription,
      this.spareParts,
      this.oils,
      this.totalPartsCost,
      this.totalCost,
      this.serviceCost,
      this.paymentStatus,
      this.paidAmount,
      this.dueAmount,
      this.paymentMethod,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.oilsCost});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tractor =
        json['tractor'] != null ? new Tractor.fromJson(json['tractor']) : null;
    customerName = json['customerName'];
    customerContact = json['customerContact'];
    customerAddress = json['customerAddress'];
    serviceType = json['serviceType'];
    serviceDescription = json['serviceDescription'];
    if (json['spareParts'] != null) {
      spareParts = <SpareParts>[];
      json['spareParts'].forEach((v) {
        spareParts!.add(new SpareParts.fromJson(v));
      });
    }
    if (json['oils'] != null) {
      oils = <Oils>[];
      json['oils'].forEach((v) {
        oils!.add(new Oils.fromJson(v));
      });
    }
    totalPartsCost = json['totalPartsCost'];
    totalCost = json['totalCost'];
    serviceCost = json['serviceCost'];
    paymentStatus = json['paymentStatus'];
    paidAmount = json['paidAmount'];
    dueAmount = json['dueAmount'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    oilsCost = json['oilsCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    data['customerName'] = this.customerName;
    data['customerContact'] = this.customerContact;
    data['customerAddress'] = this.customerAddress;
    data['serviceType'] = this.serviceType;
    data['serviceDescription'] = this.serviceDescription;
    if (this.spareParts != null) {
      data['spareParts'] = this.spareParts!.map((v) => v.toJson()).toList();
    }
    if (this.oils != null) {
      data['oils'] = this.oils!.map((v) => v.toJson()).toList();
    }
    data['totalPartsCost'] = this.totalPartsCost;
    data['totalCost'] = this.totalCost;
    data['serviceCost'] = this.serviceCost;
    data['paymentStatus'] = this.paymentStatus;
    data['paidAmount'] = this.paidAmount;
    data['dueAmount'] = this.dueAmount;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['oilsCost'] = this.oilsCost;
    return data;
  }
}

class Tractor {
  String? sId;
  String? modelName;

  Tractor({this.sId, this.modelName});

  Tractor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    modelName = json['modelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    return data;
  }
}

class SpareParts {
  PartId? partId;
  int? quantity;
  int? cost;
  String? sId;

  SpareParts({this.partId, this.quantity, this.cost, this.sId});

  SpareParts.fromJson(Map<String, dynamic> json) {
    partId =
        json['partId'] != null ? new PartId.fromJson(json['partId']) : null;
    quantity = json['quantity'];
    cost = json['cost'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.partId != null) {
      data['partId'] = this.partId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['_id'] = this.sId;
    return data;
  }
}

class PartId {
  String? sId;
  String? partName;
  String? partNumber;
  String? description;
  String? category;
  String? subCategory;
  int? price;
  int? quantity;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PartId(
      {this.sId,
      this.partName,
      this.partNumber,
      this.description,
      this.category,
      this.subCategory,
      this.price,
      this.quantity,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PartId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    partName = json['partName'];
    partNumber = json['partNumber'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    price = json['price'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['partName'] = this.partName;
    data['partNumber'] = this.partNumber;
    data['description'] = this.description;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Oils {
  OilId? oilId;
  int? quantity;
  int? cost;
  String? sId;

  Oils({this.oilId, this.quantity, this.cost, this.sId});

  Oils.fromJson(Map<String, dynamic> json) {
    oilId = json['oilId'] != null ? new OilId.fromJson(json['oilId']) : null;
    quantity = json['quantity'];
    cost = json['cost'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oilId != null) {
      data['oilId'] = this.oilId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['_id'] = this.sId;
    return data;
  }
}

class OilId {
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

  OilId(
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

  OilId.fromJson(Map<String, dynamic> json) {
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
