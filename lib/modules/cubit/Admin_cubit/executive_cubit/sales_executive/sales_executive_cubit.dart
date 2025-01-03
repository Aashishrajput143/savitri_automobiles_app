import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/sales_executive/sales_person_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/usersrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class SalesPersonCubit extends Cubit<SalesPersonState> {
  final UsersRepository usersrepository = UsersRepository();
  SalesPersonCubit() : super(SalesPersonLoading()) {
    getUsers();
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getUsers() async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "page": 1,
        "pageSize": 10,
        "role": "SALES_EXECUTIVE"
      };

      try {
        GetUsersModel response = await usersrepository.getUsersApi(requestData);
        emit(SalesPersonLoaded(getusers: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(SalesPersonError(message: errorResponse['message']));
            return;
          } else {
            emit(SalesPersonError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(SalesPersonError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
