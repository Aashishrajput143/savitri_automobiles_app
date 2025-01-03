import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/login_cubit/login_state.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

import '../../model/loginmodel.dart';
import '../../repository/loginrepository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;
  LoginCubit(this._repository) : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  var getloginModel = LoginModel();

  void setLogindata(LoginModel value) => getloginModel = value;

  Future<void> logIn(String email, String password) async {
    emit(LoginLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"email": email, "password": password};

      try {
        LoginModel response = await _repository.logInApi(requestData);

        setRxRequestStatus(Status.COMPLETED);
        setLogindata(response);

        if (response.statusCode == 200 && response.data?.accessToken != null) {
          Utils.savePreferenceValues(
              Constants.accessToken, "${response.data?.accessToken}");
          Utils.savePreferenceValues(Constants.role, "${response.data?.role}");

          if (response.data?.role == "ADMINISTRATOR") {
            emit(LoginSuccessAdmin(message: response.data?.role ?? "Unknown"));
          } else if (response.data?.role == "SALES_EXECUTIVE") {
            emit(LoginSuccessSales(message: response.data?.role ?? "Unknown"));
          } else if (response.data?.role == "SERVICE_EXECUTIVE") {
            emit(
                LoginSuccessService(message: response.data?.role ?? "Unknown"));
          } else if (response.data?.role == "COLLECTION_EXECUTIVE") {
            emit(LoginSuccessCollection(
                message: response.data?.role ?? "Unknown"));
          } else {
            emit(LoginError(message: "Role not recognized"));
          }

          CommonMethods.showToast("${response.message}");
        } else {
          emit(LoginError(message: response.message ?? "Login failed...."));
          return;
        }

        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(LoginError(message: errorResponse['message']));
            return;
          } else {
            emit(LoginError(message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(LoginError(message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(LoginError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
