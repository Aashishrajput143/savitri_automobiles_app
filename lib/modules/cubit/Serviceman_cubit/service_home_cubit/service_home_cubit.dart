import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_home_cubit/service_home_states.dart';
import 'package:savitri_automobiles_admin/modules/model/getlogoutmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/loginrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ServiceHomeCubit extends Cubit<ServiceHomeStates> {
  final LoginRepository repository = LoginRepository();
  final ServiceRepository servicerepository = ServiceRepository();
  ServiceHomeCubit() : super(const ServiceHomeLoading()) {
    getServiceEntries();
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

  Future<void> logoutApi(context) async {
    emit(const ServiceHomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      try {
        GetLogoutModel response = await repository.logoutApi();
        Utils.savePreferenceValues(Constants.accessToken, "");
        Utils.savePreferenceValues(Constants.role, "");
        emit(ServiceHomeLogout(message: response.message ?? ""));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceHomeError(message: errorResponse['message']));
            return;
          } else {
            emit(const ServiceHomeError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceHomeError(message: "${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ServiceHomeError(message: appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getServiceEntries() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetServiceEntryModel response =
            await servicerepository.getServiceEntries(requestData);
        emit(ServiceHomeLoaded(getServiceEntries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceHomeError(message: errorResponse['message']));
            return;
          } else {
            emit(const ServiceHomeError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceHomeError(message: "${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ServiceHomeError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
