import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/getoilmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/oilinventorymodel.dart';

class OilRepository {
  final _apiServices = NetworkApiServices();

  Future<GetOilModel> getoilApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.getoil);
    return GetOilModel.fromJson(response);
  }

  Future<OilInventoryModel> oilinventory(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.oilinventory);
    return OilInventoryModel.fromJson(response);
  }
}
