import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/service_executive/service_executive_details_state.dart';
import 'package:savitri_automobiles_admin/modules/model/servicecountmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ServiceExecutiveDetailsCubit extends Cubit<ServiceDetailsState> {
  final ServiceRepository servicerepository = ServiceRepository();
  ServiceExecutiveDetailsCubit(String? id) : super(ServiceDetailsLoading()) {
    getServiceCountApi(id);
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
        emit(ServiceDetailsLoaded(servicecount: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceDetailsError(message: errorResponse['message']));
            return;
          } else {
            emit(ServiceDetailsError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ServiceDetailsError(
              message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ServiceDetailsError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
