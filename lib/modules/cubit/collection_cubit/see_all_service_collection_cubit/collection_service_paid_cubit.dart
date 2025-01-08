import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/collection_cubit/see_all_service_collection_cubit/collection_service_paid_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class CollectionServicePaidCubit extends Cubit<CollectionServicePaidStates> {
  final ServiceRepository servicerepository = ServiceRepository();
  CollectionServicePaidCubit() : super(const CollectionServicePaidLoading()) {
    getServiceEntries("PAID");
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

  Future<void> getServiceEntries(String status) async {
    emit(const CollectionServicePaidLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 20,
        "status": status //"PAID"
      };

      try {
        GetServiceEntryModel response =
            await servicerepository.getServiceEntries(requestData);
        emit(CollectionServicePaidLoaded(getServiceEntries: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(CollectionServicePaidError(message: errorResponse['message']));
            return;
          } else {
            emit(const CollectionServicePaidError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(CollectionServicePaidError(
              message: "${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(CollectionServicePaidError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}