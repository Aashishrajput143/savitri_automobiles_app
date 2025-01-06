import 'package:savitri_automobiles_admin/data/app_url/app_url.dart';
import 'package:savitri_automobiles_admin/data/network/network_api_services.dart';
import 'package:savitri_automobiles_admin/modules/model/addsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescountpendingpaidmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';

class SalesRepository {
  final _apiServices = NetworkApiServices();

  Future<GetTractorModel> getTractorApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.gettractor);
    return GetTractorModel.fromJson(response);
  }

  Future<GetImplementModel> getImplementApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getimplement);
    return GetImplementModel.fromJson(response);
  }

  Future<AddSalesEntryModel> addSalesEntryApi(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.addsalesentry);
    return AddSalesEntryModel.fromJson(response);
  }

  Future<GetSalesEntryModel> getSalesEntries(var data) async {
    dynamic response =
        await _apiServices.postEncodeApi(data, AppUrl.getsalesentry);
    return GetSalesEntryModel.fromJson(response);
  }

  Future<GetSalesEntryDetailsModel> getSalesEntriesDetails(var data) async {
    dynamic response =
        await _apiServices.getApi("${AppUrl.getsalesentrydetails}$data");
    return GetSalesEntryDetailsModel.fromJson(response);
  }

  Future<SalesCountPendingPaidModel> getSalesCountPendingPaidApi() async {
    dynamic response =
        await _apiServices.getApi(AppUrl.getsalescountpendingpaid);
    return SalesCountPendingPaidModel.fromJson(response);
  }

  Future<SalesCountTractorImplementModel> getSalesCounttractorimplementApi(
      var data) async {
    dynamic response = await _apiServices
        .getApi("${AppUrl.salesEquipementCount}?salerId=$data");
    return SalesCountTractorImplementModel.fromJson(response);
  }
}
