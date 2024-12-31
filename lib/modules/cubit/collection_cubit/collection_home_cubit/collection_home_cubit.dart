import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/collection_cubit/collection_home_cubit/collection_home_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getlogoutmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/loginrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class CollectionHomeCubit extends Cubit<CollectionHomeStates> {
  final SalesRepository salesrepository = SalesRepository();
  final LoginRepository logoutrepository = LoginRepository();
  CollectionHomeCubit() : super(const CollectionHomeLoading()) {
    getSalesEntries();
  }
  String getdate(String datetime, bool date) {
    String dateTime = datetime;
    List<String> dT = dateTime.split('T');
    if (date) {
      return dT[0];
    }
    return dT[1];
    // Output: ['2024-12-19', '12:07:02.910Z']
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getSalesEntries() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 20,
        "status": "PENDING" //"PAID"
      };

      try {
        GetSalesEntryModel response =
            await salesrepository.getSalesEntries(requestData);
        emit(CollectionHomeLoaded(getSalesEntries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(CollectionHomeError(message: errorResponse['message']));
            return;
          } else {
            emit(const CollectionHomeError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(CollectionHomeError(
              message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(CollectionHomeError(message: appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> logoutApi(context) async {
    emit(const CollectionHomeLoading());
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      try {
        GetLogoutModel response = await logoutrepository.logoutApi();
        Utils.savePreferenceValues(Constants.accessToken, "");
        Utils.savePreferenceValues(Constants.role, "");
        emit(CollectionHomeLogout(message: response.message ?? ""));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(CollectionHomeError(message: errorResponse['message']));
            return;
          } else {
            emit(const CollectionHomeError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(CollectionHomeError(
              message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(CollectionHomeError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
