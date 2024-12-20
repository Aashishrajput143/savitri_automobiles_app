class GetImplementModel {
  String? message;
  Data? data;
  int? statusCode;

  GetImplementModel({this.message, this.data, this.statusCode});

  GetImplementModel.fromJson(Map<String, dynamic> json) {
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
  String? brandName;
  String? modelName;
  String? type;
  String? category;
  String? power;
  int? price;
  int? quantity;
  String? description;
  String? status;
  List<dynamic>? configurations;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Docs(
      {this.sId,
      this.brandName,
      this.modelName,
      this.type,
      this.category,
      this.power,
      this.price,
      this.quantity,
      this.description,
      this.status,
      this.configurations,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brandName'];
    modelName = json['modelName'];
    type = json['type'];
    category = json['category'];
    power = json['power'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    status = json['status'];
    if (json['configurations'] != null) {
      configurations = <Null>[];
      json['configurations'].forEach((v) {
        configurations!.add(Null);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brandName'] = this.brandName;
    data['modelName'] = this.modelName;
    data['type'] = this.type;
    data['category'] = this.category;
    data['power'] = this.power;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.configurations != null) {
      data['configurations'] =
          this.configurations!.map((v) => v?.Json()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
