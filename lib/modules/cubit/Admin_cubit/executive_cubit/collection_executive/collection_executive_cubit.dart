import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/collection_executive/collection_person_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getusersmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/usersrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class CollectionPersonCubit extends Cubit<CollectionPersonState> {
  final UsersRepository usersrepository = UsersRepository();
  CollectionPersonCubit() : super(CollectionPersonLoading()) {
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
        "role": "COLLECTION_EXECUTIVE"
      };

      try {
        GetUsersModel response = await usersrepository.getUsersApi(requestData);
        emit(CollectionPersonLoaded(getusers: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(CollectionPersonError(message: errorResponse['message']));
            return;
          } else {
            emit(CollectionPersonError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(CollectionPersonError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
