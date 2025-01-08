import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_executive_details_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescountpendingpaidmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class CollectionExecutiveDetailsCubit
    extends Cubit<CollectionExecutiveDetailsState> {
  final SalesRepository salesrepository = SalesRepository();
  CollectionExecutiveDetailsCubit()
      : super(CollectionExecutiveDetailsLoading()) {
    getSalesCountPaidPendingApi();
    getSalesEntries();
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

  Future<void> getSalesEntries() async {
    CollectionExecutiveDetailsLoading();
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 5,
        "status": "PENDING", //"PAID"
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
            emit(CollectionExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(CollectionExecutiveDetailsError(
                "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(CollectionExecutiveDetailsError(
              "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(CollectionExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesCountPaidPendingApi() async {
    CollectionExecutiveDetailsLoading();
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesCountPendingPaidModel response =
            await salesrepository.getSalesCountPendingPaidApi();
        emit(state.copyWith(getpendingpaidcount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(CollectionExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(CollectionExecutiveDetailsError(
                "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(
              CollectionExecutiveDetailsError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(CollectionExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }
}
