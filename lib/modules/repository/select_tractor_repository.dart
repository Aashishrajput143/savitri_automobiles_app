import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/model/tractorinventorymodel.dart';

class TractorRepository {
  final _apiServices = NetworkApiServices();

  Future<GetTractorModel> getTractorApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.gettractor);
    return GetTractorModel.fromJson(response);
  }

  Future<TractorInventoryModel> tractorinventory(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.tractorinventory);
    return TractorInventoryModel.fromJson(response);
  }
}
