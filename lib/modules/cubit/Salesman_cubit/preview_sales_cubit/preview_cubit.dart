import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/preview_sales_cubit/preview_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';

import '../../../../Constants/utils.dart';
import '../../../../common/commonmethods.dart';
import '../../../../data/response/status.dart';
import '../../../../resources/strings.dart';

class PreviewCubit extends Cubit<PreviewState> {
  final repository = SalesRepository();

  PreviewCubit(String id) : super(PreviewLoading()) {
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
        GetSalesEntryDetailsModel response =
            await repository.getSalesEntriesDetails(id);
        emit(PreviewSuccess(getSalesDetailsByIDModel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(PreviewError(message: errorResponse['message']));
            return;
          } else {
            emit(PreviewError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(PreviewError(message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(PreviewError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
