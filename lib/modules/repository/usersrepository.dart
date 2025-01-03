import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';

class UsersRepository {
  final _apiServices = NetworkApiServices();

  Future<GetUsersModel> getUsersApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.getusers);
    return GetUsersModel.fromJson(response);
  }
}
