import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/addserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getoilmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrydetailmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getservicegraphmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';

class ServiceRepository {
  final _apiServices = NetworkApiServices();

  Future<GetTractorModel> getTractorApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.gettractor);
    return GetTractorModel.fromJson(response);
  }

  Future<GetSparePartsModel> getsparepartsApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getspareparts);
    return GetSparePartsModel.fromJson(response);
  }

  Future<GetOilModel> getoilApi(var data) async {
    dynamic response = await _apiServices.postEncodeApi(data, AppUrl.getoil);
    return GetOilModel.fromJson(response);
  }

  Future<AddServiceEntryModel> addServiceEntryApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.addserviceentry);
    return AddServiceEntryModel.fromJson(response);
  }

  Future<GetServiceEntryModel> getServiceEntries(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getserviceentry);
    return GetServiceEntryModel.fromJson(response);
  }

  Future<GetServiceEntryDetailModel> getServiceEntriesDetails(var data) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getserviceentrydetail}$data");
    return GetServiceEntryDetailModel.fromJson(response);
  }

  Future<ServiceCountModel> getServiceCountApi(var data) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.servicecount}?addedBy=$data");
    return ServiceCountModel.fromJson(response);
  }

  Future<ServiceCountModel> getServiceCountallApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.servicecount);
    return ServiceCountModel.fromJson(response);
  }

  Future<GetServiceGraphModel> getServiceGraphApi() async {
    dynamic response = await _apiServices.getApi(AppUrl.servicegraph);
    return GetServiceGraphModel.fromJson(response);
  }
}
