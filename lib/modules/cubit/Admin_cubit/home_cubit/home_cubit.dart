import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/home_cubit/home_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getlogoutmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/loginrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class HomeCubit extends Cubit<HomeState> {
  final SalesRepository salesrepository = SalesRepository();
  final LoginRepository logoutrepository = LoginRepository();

  final ServiceRepository servicerepository = ServiceRepository();
  HomeCubit() : super(HomeLoading()) {
    getSalesEntries();
    getSalesCountApi();
    getServiceEntries();
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

  Future<void> logoutApi(context) async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      try {
        GetLogoutModel response = await logoutrepository.logoutApi();
        Utils.savePreferenceValues(Constants.accessToken, "");
        Utils.savePreferenceValues(Constants.role, "");
        emit(HomeLogout(response.message ?? ""));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(HomeError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesCountApi() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesCountTractorImplementModel response =
            await salesrepository.getSalesCountAllApi();
        emit(state.copyWith(getSalesCount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(HomeError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesEntries() async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 5};

      try {
        GetSalesEntryModel response =
            await salesrepository.getSalesEntries(requestData);
        emit(state.copyWith(getSalesEntries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(HomeError("${error.toString()} failed..."));
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getServiceEntries() async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 5};

      try {
        GetServiceEntryModel response =
            await servicerepository.getServiceEntries(requestData);
        emit(state.copyWith(getServiceEntries: response));
        print(
            "gbskgf=====?> ${state.getServiceEntries?.data?.docs?[0].customerName}");

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(HomeError("${error.toString()} failed..."));
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }
}
