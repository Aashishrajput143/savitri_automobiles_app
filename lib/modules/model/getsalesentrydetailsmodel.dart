class GetSalesEntryDetailsModel {
  String? message;
  Data? data;
  int? statusCode;

  GetSalesEntryDetailsModel({this.message, this.data, this.statusCode});

  GetSalesEntryDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Registration? registration;
  Insurance? insurance;
  String? sId;
  String? salesPerson;
  Tractor? tractor;
  List<Equipments>? equipments;
  String? customerName;
  String? customerEmail;
  String? customerContact;
  bool? isExchange;
  int? exchangeAmount;
  ExchangeItem? exchangeItem;
  int? transportationCost;
  int? tractorBasePrice;
  int? paidAmount;
  int? dueAmount;
  int? totalAmount;
  int? insuranceAmount;
  int? registrationAmount;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? customerAddress;
  Finance? finance;

  Data(
      {this.registration,
      this.insurance,
      this.sId,
      this.salesPerson,
      this.tractor,
      this.equipments,
      this.customerName,
      this.customerEmail,
      this.customerContact,
      this.isExchange,
      this.exchangeAmount,
      this.exchangeItem,
      this.transportationCost,
      this.tractorBasePrice,
      this.paidAmount,
      this.dueAmount,
      this.totalAmount,
      this.insuranceAmount,
      this.registrationAmount,
      this.paymentMethod,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.customerAddress,
      this.finance});

  Data.fromJson(Map<String, dynamic> json) {
    registration = json['registration'] != null
        ? new Registration.fromJson(json['registration'])
        : null;
    insurance = json['insurance'] != null
        ? new Insurance.fromJson(json['insurance'])
        : null;
    sId = json['_id'];
    salesPerson = json['salesPerson'];
    tractor =
        json['tractor'] != null ? new Tractor.fromJson(json['tractor']) : null;
    if (json['equipments'] != null) {
      equipments = <Equipments>[];
      json['equipments'].forEach((v) {
        equipments!.add(new Equipments.fromJson(v));
      });
    }
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    customerContact = json['customerContact'];
    isExchange = json['isExchange'];
    exchangeAmount = json['exchangeAmount'];
    exchangeItem = json['exchangeItem'] != null
        ? new ExchangeItem.fromJson(json['exchangeItem'])
        : null;
    transportationCost = json['transportationCost'];
    tractorBasePrice = json['tractorBasePrice'];
    paidAmount = json['paidAmount'];
    dueAmount = json['dueAmount'];
    totalAmount = json['totalAmount'];
    insuranceAmount = json['insuranceAmount'];
    registrationAmount = json['registrationAmount'];
    paymentMethod = json['paymentMethod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    customerAddress = json['customerAddress'];
    finance =
        json['finance'] != null ? new Finance.fromJson(json['finance']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.registration != null) {
      data['registration'] = this.registration!.toJson();
    }
    if (this.insurance != null) {
      data['insurance'] = this.insurance!.toJson();
    }
    data['_id'] = this.sId;
    data['salesPerson'] = this.salesPerson;
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    if (this.equipments != null) {
      data['equipments'] = this.equipments!.map((v) => v.toJson()).toList();
    }
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['customerContact'] = this.customerContact;
    data['isExchange'] = this.isExchange;
    data['exchangeAmount'] = this.exchangeAmount;
    if (this.exchangeItem != null) {
      data['exchangeItem'] = this.exchangeItem!.toJson();
    }
    data['transportationCost'] = this.transportationCost;
    data['tractorBasePrice'] = this.tractorBasePrice;
    data['paidAmount'] = this.paidAmount;
    data['dueAmount'] = this.dueAmount;
    data['totalAmount'] = this.totalAmount;
    data['insuranceAmount'] = this.insuranceAmount;
    data['registrationAmount'] = this.registrationAmount;
    data['paymentMethod'] = this.paymentMethod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['customerAddress'] = this.customerAddress;
    if (this.finance != null) {
      data['finance'] = this.finance!.toJson();
    }
    return data;
  }
}

class Registration {
  String? registrationType;
  int? registrationCost;

  Registration({this.registrationType, this.registrationCost});

  Registration.fromJson(Map<String, dynamic> json) {
    registrationType = json['registrationType'];
    registrationCost = json['registrationCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registrationType'] = this.registrationType;
    data['registrationCost'] = this.registrationCost;
    return data;
  }
}

class Insurance {
  String? insuranceProvider;
  int? insuranceCost;

  Insurance({this.insuranceProvider, this.insuranceCost});

  Insurance.fromJson(Map<String, dynamic> json) {
    insuranceProvider = json['insuranceProvider'];
    insuranceCost = json['insuranceCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insuranceProvider'] = this.insuranceProvider;
    data['insuranceCost'] = this.insuranceCost;
    return data;
  }
}

class Tractor {
  String? sId;
  String? modelName;
  dynamic engineMakeAndType;
  dynamic horsepower;
  dynamic engineCapacity;
  dynamic numberOfCylinders;
  dynamic coolingSystem;
  dynamic fuelType;
  dynamic fuelCapacity;
  dynamic features;
  dynamic yearOfManufacture;

  Tractor(
      {this.sId,
      this.modelName,
      this.engineMakeAndType,
      this.horsepower,
      this.engineCapacity,
      this.numberOfCylinders,
      this.coolingSystem,
      this.fuelType,
      this.fuelCapacity,
      this.yearOfManufacture,
      this.features});

  Tractor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    modelName = json['modelName'];
    engineMakeAndType = json['engineMakeAndType'];
    horsepower = json['horsepower'];
    engineCapacity = json['engineCapacity'];
    numberOfCylinders = json['numberOfCylinders'];
    coolingSystem = json['coolingSystem'];
    fuelType = json['fuelType'];
    fuelCapacity = json['fuelCapacity'];
    yearOfManufacture = json['yearOfManufacture'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    data['engineMakeAndType'] = this.engineMakeAndType;
    data['horsepower'] = this.horsepower;
    data['engineCapacity'] = this.engineCapacity;
    data['numberOfCylinders'] = this.numberOfCylinders;
    data['coolingSystem'] = this.coolingSystem;
    data['fuelType'] = this.fuelType;
    data['fuelCapacity'] = this.fuelCapacity;
    data['yearOfManufacture'] = this.yearOfManufacture;
    data['features'] = this.features;
    return data;
  }
}

class Equipments {
  String? sId;
  String? modelName;
  int? price;

  Equipments({this.sId, this.modelName, this.price});

  Equipments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    modelName = json['modelName'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    data['price'] = this.price;
    return data;
  }
}

class ExchangeItem {
  int? amount;
  String? description;
  String? model;
  String? brand;
  String? vehicleType;
  int? vehicleAge;
  String? sId;

  ExchangeItem(
      {this.amount,
      this.description,
      this.model,
      this.brand,
      this.vehicleType,
      this.vehicleAge,
      this.sId});

  ExchangeItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
    model = json['model'];
    brand = json['brand'];
    vehicleType = json['vehicleType'];
    vehicleAge = json['vehicleAge'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['model'] = this.model;
    data['brand'] = this.brand;
    data['vehicleType'] = this.vehicleType;
    data['vehicleAge'] = this.vehicleAge;
    data['_id'] = this.sId;
    return data;
  }
}

class Finance {
  int? amount;
  String? tenure;
  String? sId;

  Finance({this.amount, this.tenure, this.sId});

  Finance.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    tenure = json['tenure'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['tenure'] = this.tenure;
    data['_id'] = this.sId;
    return data;
  }
}
