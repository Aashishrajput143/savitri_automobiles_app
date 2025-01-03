import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/home_cubit/home_state.dart';
import 'package:savitri_automobiles_admin/modules/model/getlogoutmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/modules/repository/loginrepository.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class HomeCubit extends Cubit<HomeState> {
  final SalesRepository salesrepository = SalesRepository();
  final LoginRepository logoutrepository = LoginRepository();

  final ServiceRepository servicerepository = ServiceRepository();
  final List<Map<String, dynamic>> salesperson = [
    {
      "name": "Rajendra Singh",
      "id": "#100052",
      "profile": AppImages.profile,
    },
    {
      "name": "Pawan Kumar",
      "id": "#100049",
      "profile": AppImages.profile,
    },
    {
      "name": "Nipendra Singh",
      "id": "#100045",
      "profile": AppImages.profile,
    },
  ];

  HomeCubit() : super(HomeLoading()) {
    getSalesEntries();
    //getServiceEntries();
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

  Future<void> logoutApi(context) async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      try {
        GetLogoutModel response = await logoutrepository.logoutApi();
        Utils.savePreferenceValues(Constants.accessToken, "");
        Utils.savePreferenceValues(Constants.role, "");
        emit(HomeLogout(response.message ?? ""));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(HomeError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSalesEntries() async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 5};

      try {
        GetSalesEntryModel response =
            await salesrepository.getSalesEntries(requestData);
        emit(state.copyWith(
            getSalesEntries: response, salesperson: salesperson));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getServiceEntries() async {
    emit(HomeLoading());
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 5};

      try {
        GetServiceEntryModel response =
            await servicerepository.getServiceEntries(requestData);
        emit(state.copyWith(getServiceEntries: response));
        print(
            "gbskgf=====?> ${state.getServiceEntries?.data?.docs?[0].customerName}");

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(HomeError(errorResponse['message']));
            return;
          } else {
            emit(HomeError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
        }
      }
    } else {
      emit(HomeError(appStrings.weUnableCheckData));
      return;
    }
  }

  Widget buildCard(BuildContext context, entries, String value) {
    print(value);
    return InkWell(
      onTap: () {
        if (value == "sales") {
          Navigator.pushNamed(
            context,
            Routes.salespreview,
            arguments: entries?.sId ?? "",
          );
        } else {
          Navigator.pushNamed(
            context,
            Routes.servicereview,
            arguments: entries?.sId ?? "",
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                AppImages.swaraj735XT,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Text(
                        "No Image",
                        style: TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tractor Model Name
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        entries?.tractor?.modelName ?? "Not Available",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (value == "sales") ...[
                      Text(
                        "₹${PriceFormatter.formatPrice(entries?.totalAmount ?? 0)}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Salesman Name
                      Text(
                        "Salesman: ${entries?.customerName ?? "Not Available"}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    if (value != "sales") ...[
                      Text(
                        "₹${PriceFormatter.formatPrice(entries?.totalCost ?? 0)} ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Serviceman : ${entries?.customerName ?? "Not Available"}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],

                    // Total Amount

                    const SizedBox(height: 5),
                    // Date
                    Text(
                      getdate(entries?.createdAt ?? "", true),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 138, 137, 137),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // View Details Section
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Center(
                heightFactor: 5.5,
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 119, 33, 135),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
