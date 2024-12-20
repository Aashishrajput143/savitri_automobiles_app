import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';

import '../model/loginmodel.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<LoginModel> logInApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.login);
    return LoginModel.fromJson(response);
  }
}
