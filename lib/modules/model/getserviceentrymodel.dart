class GetServiceEntryModel {
  String? message;
  Data? data;
  int? statusCode;

  GetServiceEntryModel({this.message, this.data, this.statusCode});

  GetServiceEntryModel.fromJson(Map<String, dynamic> json) {
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
  Tractor? tractor;
  String? customerName;
  String? customerEmail;
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

  Docs(
      {this.sId,
      this.tractor,
      this.customerName,
      this.customerEmail,
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
      this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tractor =
        json['tractor'] != null ? new Tractor.fromJson(json['tractor']) : null;
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
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
    return data;
  }
}

class Tractor {
  String? sId;
  String? modelName;
  int? yearOfManufacture;

  Tractor({this.sId, this.modelName, this.yearOfManufacture});

  Tractor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    modelName = json['modelName'];
    yearOfManufacture = json['yearOfManufacture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['modelName'] = this.modelName;
    data['yearOfManufacture'] = this.yearOfManufacture;
    return data;
  }
}

class SpareParts {
  String? partId;
  int? quantity;
  int? cost;
  String? sId;

  SpareParts({this.partId, this.quantity, this.cost, this.sId});

  SpareParts.fromJson(Map<String, dynamic> json) {
    partId = json['partId'];
    quantity = json['quantity'];
    cost = json['cost'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partId'] = this.partId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['_id'] = this.sId;
    return data;
  }
}

class Oils {
  String? oilId;
  int? quantity;
  int? cost;
  String? sId;

  Oils({this.oilId, this.quantity, this.cost, this.sId});

  Oils.fromJson(Map<String, dynamic> json) {
    oilId = json['oilId'];
    quantity = json['quantity'];
    cost = json['cost'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oilId'] = this.oilId;
    data['quantity'] = this.quantity;
    data['cost'] = this.cost;
    data['_id'] = this.sId;
    return data;
  }
}
