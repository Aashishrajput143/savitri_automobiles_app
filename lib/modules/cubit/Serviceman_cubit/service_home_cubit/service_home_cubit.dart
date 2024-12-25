import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_home_cubit/service_home_states.dart';
import 'package:savitri_automobiles_admin/modules/model/getlogoutmodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/loginrepository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class ServiceHomeCubit extends Cubit<ServiceHomeStates> {
  final LoginRepository repository = LoginRepository();
  ServiceHomeCubit() : super(const ServiceHomeLoading()) {
    //getSalesEntries();
  }
  // final List<Map<String, dynamic>> recentlyAdded;
  // final List<Map<String, dynamic>> topSellingTractor;

  // ServiceHomeCubit()
  //     : recentlyAdded = [
  //         {
  //           "name": "Swaraj 735FE",
  //           "price": "₹16,80,590",
  //           "image": AppImages.swaraj735FE,
  //           "Buyer": "Rajendra Singh",
  //           "date": "20 Oct 2024"
  //         },
  //         {
  //           "name": "Swaraj 735XT",
  //           "price": "₹36,00,000",
  //           "image": AppImages.swaraj735XT,
  //           "Buyer": "Nipendra Singh",
  //           "date": "20 Oct 2024"
  //         },
  //         {
  //           "name": "Swaraj 735XT",
  //           "price": "₹36,00,000",
  //           "image": AppImages.swaraj735XT,
  //           "Buyer": "Shailendra Singh",
  //           "date": "20 Oct 2024"
  //         },
  //         {
  //           "name": "Swaraj 735XT",
  //           "price": "₹36,00,000",
  //           "image": AppImages.swaraj735XT,
  //           "Buyer": "Surendra Singh",
  //           "date": "20 Oct 2024"
  //         },
  //       ],
  //       topSellingTractor = [
  //         {
  //           "name": "Swaraj 735FE",
  //           "price": "₹26,80,590",
  //           "image": AppImages.swaraj735FE,
  //           "PTO": "24 HP",
  //           "RPM": 2800
  //         },
  //         {
  //           "name": "Swaraj 735XT",
  //           "price": "₹36,00,000",
  //           "image": AppImages.swaraj735XT,
  //           "PTO": "24 HP",
  //           "RPM": 2800
  //         },
  //         {
  //           "name": "Swaraj 735FEePS",
  //           "price": "₹18,00,000",
  //           "image": AppImages.tractor735FEePS,
  //           "PTO": "24 HP",
  //           "RPM": 2800
  //         },
  //         {
  //           "name": "Swaraj 735XT10",
  //           "price": "₹16,00,000",
  //           "image": AppImages.tractor,
  //           "PTO": "24 HP",
  //           "RPM": 2800
  //         },
  //       ],
  //       super(const ServiceHomeInitial());

  // Future<void> addServiceEntry() async {
  //   emit(const ServiceHomeLoading());
  //   try {
  //     await Future.delayed(const Duration(seconds: 2));

  //     // Simulate navigation trigger
  //     emit(const ServiceHomeSuccess(message: 'Navigate to next screen'));
  //   } catch (e) {
  //     emit(ServiceHomeError(message: 'An error occurred: ${e.toString()}'));
  //   }
  // }

  // List<Map<String, dynamic>> getRecentlyAdded() => recentlyAdded;

  // List<Map<String, dynamic>> getTopSellingTractor() => topSellingTractor;

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> logoutApi(context) async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      try {
        GetLogoutModel response = await repository.logoutApi();
        emit(ServiceHomeLogout(message: response.message ?? ""));
        Utils.savePreferenceValues(Constants.accessToken, "");
        Utils.savePreferenceValues(Constants.role, "");
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (Route<dynamic> route) => false,
        );

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(ServiceHomeError(message: errorResponse['message']));
            return;
          } else {
            emit(const ServiceHomeError(
                message: "An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(
              ServiceHomeError(message: "${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ServiceHomeError(message: appStrings.weUnableCheckData));
      return;
    }
  }
}
