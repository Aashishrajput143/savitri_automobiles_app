import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/service_executive/service_executive_details_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ServiceExecutiveDetailsCubit extends Cubit<ServiceExecutiveDetailsState> {
  final ServiceRepository servicerepository = ServiceRepository();
  ServiceExecutiveDetailsCubit(String? id)
      : super(ServiceExecutiveDetailsLoading()) {
    getServiceCountApi(id);
    getServiceEntries(id);
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

  Future<void> getServiceCountApi(var id) async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        ServiceCountModel response =
            await servicerepository.getServiceCountApi(id);
        emit(state.copyWith(getServicecount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(ServiceExecutiveDetailsError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceExecutiveDetailsError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ServiceExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getServiceEntries(var id) async {
    emit(ServiceExecutiveDetailsLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 20,
        "service": id
      };

      try {
        GetServiceEntryModel response =
            await servicerepository.getServiceEntries(requestData);
        emit(state.copyWith(getServiceentries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceExecutiveDetailsError(errorResponse['message']));
            return;
          } else {
            emit(ServiceExecutiveDetailsError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceExecutiveDetailsError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(ServiceExecutiveDetailsError(appStrings.weUnableCheckData));
      return;
    }
  }
}
