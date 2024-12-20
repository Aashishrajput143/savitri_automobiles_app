import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/review_sales_cubit/review_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';

import '../../../../Constants/utils.dart';
import '../../../../common/commonmethods.dart';
import '../../../../data/response/status.dart';
import '../../../../resources/strings.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final repository = SalesRepository();

  ReviewCubit() : super(ReviewLoading()) {
    getDetailsData("6763d0cddf12be477bbdfe24");
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
        emit(ReviewSuccess(getSalesDetailsByIDModel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ReviewError(message: errorResponse['message']));
            return;
          } else {
            emit(ReviewError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ReviewError(message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ReviewError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
