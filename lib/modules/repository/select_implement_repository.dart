import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/implementinventorymodel.dart';

class ImplementsRepository {
  final _apiServices = NetworkApiServices();

  Future<GetImplementModel> getImplementApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getimplement);
    return GetImplementModel.fromJson(response);
  }

  Future<ImplementInventoryModel> implementinventory(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.implementinventory);
    return ImplementInventoryModel.fromJson(response);
  }
}
