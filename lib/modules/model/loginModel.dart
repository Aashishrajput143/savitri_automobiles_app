

class LoginModel {
  String? message;
  Data? data;
  int? statusCode;

  LoginModel({this.message, this.data, this.statusCode});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? role;

  Data({this.accessToken, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['role'] = this.role;
    return data;
  }
}