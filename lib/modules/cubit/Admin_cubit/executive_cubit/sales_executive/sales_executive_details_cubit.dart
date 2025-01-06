import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/sales_executive/sales_executive_details_state.dart';
import 'package:savitri_automobiles_admin/modules/model/salescounttractorimplementmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class SalesExecutiveDetailsCubit extends Cubit<SalesDetailsState> {
  final SalesRepository salesrepository = SalesRepository();
  SalesExecutiveDetailsCubit(String? id) : super(SalesDetailsLoading()) {
    getSalesCountTractorImplementApi(id);
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getSalesCountTractorImplementApi(var id) async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        SalesCountTractorImplementModel response =
            await salesrepository.getSalesCounttractorimplementApi(id);
        emit(SalesDetailsLoaded(countractorimplement: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesDetailsError(message: errorResponse['message']));
            return;
          } else {
            emit(SalesDetailsError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(SalesDetailsError(
              message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(SalesDetailsError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
