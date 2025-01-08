import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/preview_service_cubit/preview_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrydetailmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class PreviewServiceCubit extends Cubit<PreviewServiceState> {
  final repository = ServiceRepository();

  PreviewServiceCubit(String id) : super(PreviewServiceLoading()) {
    getDetailsData(id);
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getDetailsData(var id) async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        GetServiceEntryDetailModel response =
            await repository.getServiceEntriesDetails(id);
        emit(PreviewServiceSuccess(getServiceDetailsByIDModel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(PreviewServiceError(message: errorResponse['message']));
            return;
          } else {
            emit(PreviewServiceError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(PreviewServiceError(message: "${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(PreviewServiceError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
