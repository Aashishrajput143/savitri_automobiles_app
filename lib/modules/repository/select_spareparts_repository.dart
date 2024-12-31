import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/sparepartsinventorymodel.dart';

class SparePartsRepository {
  final _apiServices = NetworkApiServices();

  Future<GetSparePartsModel> getsparepartsApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getspareparts);
    return GetSparePartsModel.fromJson(response);
  }

  Future<SparePartsInventoryModel> sparepartsinventory(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.sparepartinventory);
    return SparePartsInventoryModel.fromJson(response);
  }
}
