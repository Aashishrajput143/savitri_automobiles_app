import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/sales_executive/sales_executive_details_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class SalesExecutiveDetailsCubit extends Cubit<SalesExecutiveDetailsState> {
  final SalesRepository salesrepository = SalesRepository();
  SalesExecutiveDetailsCubit(String? id)
      : super(SalesExecutiveDetailsLoading()) {
    getSalesCountTractorImplementApi(id);
    getSalesEntries(id);
  }

  String getdate(String datetime, bool date) {
    String dateTime = datetime;
    List<String> dT = dateTime.split('T');
    if (date) {
      return dT[0];
    }
    return dT[1];
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getSalesCountTractorImplementApi(var id) async {
    SalesExecutiveDetailsLoading();
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesCountTractorImplementModel response =
            await salesrepository.getSalesCounttractorimplementApi(id);
        emit(state.copyWith(getSalescount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(SalesExecutiveDetailsError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(SalesExecutiveDetailsError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(SalesExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesEntries(var id) async {
    SalesExecutiveDetailsLoading();
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 20,
        "salesPerson": id
      };

      try {
        GetSalesEntryModel response =
            await salesrepository.getSalesEntries(requestData);
        emit(state.copyWith(getSalesentries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(SalesExecutiveDetailsError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(SalesExecutiveDetailsError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(SalesExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }
}
