import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class TractorRepository {
  final _apiServices = NetworkApiServices();

  Future<GetTractorModel> getTractorApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.gettractor);
    return GetTractorModel.fromJson(response);
  }
}
