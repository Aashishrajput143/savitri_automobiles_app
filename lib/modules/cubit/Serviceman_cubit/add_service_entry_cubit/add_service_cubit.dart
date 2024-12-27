import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_state.dart';
import 'package:savitri_automobiles_admin/modules/model/addserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getoilmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Service_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  final ServiceRepository servicerepository = ServiceRepository();
  AddServiceCubit() : super(AddServiceLoading()) {
    getTractor();
    getSparepartsApi();
    getoilApi();
  }

  // TextEditingControllers for fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController servicechargeController = TextEditingController();
  final TextEditingController servicedescriptionController =
      TextEditingController();

  var dropDownKey = GlobalKey<DropdownSearchState>();
  var dropDownKeyservicetype = GlobalKey<DropdownSearchState>();
  var dropDownKeypaymentmethod = GlobalKey<DropdownSearchState>();

  void selectTractor(String id) {
    final selectedTractor = state.gettractormodel?.data?.docs?.firstWhere(
      (tractor) => tractor.sId == id,
    );
    if (selectedTractor != null) {
      print("Selected Tractor: ${selectedTractor.sId}"); // Debug log

      emit(state.copyWith(
          selectedTractormodel: selectedTractor.sId,
          selectedTractor: selectedTractor));
    } else {
      print("No tractor found with ID: $id");
    }
  }

  void selectservicetype(String? type) {
    print("object1 $type");
    print("object2 $type");
    emit(state.copyWith(selectedservicetype: type));
  }

  void selectpaymentMethod(String? type) {
    print("object1 $type");
    print("object2 $type");
    emit(state.copyWith(paymentmethod: type));
  }

  String? selectedPart;
  final TextEditingController qtyController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void updateSparePart(
      String partId, String partName, String price, String quantity) {
    final updatedList =
        List<Map<String, String>>.from(state.selectedspareparts ?? []);

    final existingIndex =
        updatedList.indexWhere((item) => item['name'] == partName);

    if (existingIndex != -1) {
      updatedList[existingIndex]['quantity'] = quantity;
    } else {
      updatedList.add({
        'name': partName,
        'quantity': quantity,
        'id': partId,
        'price': price
      });
    }

    List<Map<String, dynamic>> transformedparts = updatedList.map((item) {
      return {
        "partId": item["id"] ?? "",
        "quantity": item["quantity"] ?? 0,
        "cost": item["price"] ?? 0,
      };
    }).toList();

    print(transformedparts);
    selectedPart = null;
    emit(state.copyWith(
        selectedspareparts: updatedList,
        selectedsparepartsdetails: transformedparts));
    print(state.selectedspareparts);
    print(selectedPart);
    selectedPart = null;
    qtyController.clear();
    focusNode.unfocus();
  }

  void removeSparePart(String partName) {
    final updatedList =
        List<Map<String, String>>.from(state.selectedspareparts ?? []);
    updatedList.removeWhere((item) => item['name'] == partName);
    emit(state.copyWith(selectedspareparts: updatedList));
    print(state.selectedspareparts);
  }

  String? selectedoil;
  final TextEditingController qtyoilController = TextEditingController();
  FocusNode focusNodeoil = FocusNode();

  void updateoil(
      String oilId, String oilname, String price, String oilquantity) {
    print(oilname);
    final updatedoilList =
        List<Map<String, String>>.from(state.selectedoils ?? []);

    final existingoilIndex =
        updatedoilList.indexWhere((item) => item['name'] == oilname);

    if (existingoilIndex != -1) {
      updatedoilList[existingoilIndex]['quantity'] = oilquantity;
    } else {
      updatedoilList.add({
        'name': oilname,
        'quantity': oilquantity,
        'id': oilId,
        'price': price
      });
    }
    print(updatedoilList);
    List<Map<String, dynamic>> transformedoil = updatedoilList.map((item) {
      return {
        "oilId": item["id"] ?? "",
        "quantity": item["quantity"] ?? 0,
        "cost": item["price"] ?? 0,
      };
    }).toList();

    print(transformedoil);

    emit(state.copyWith(
        selectedoils: updatedoilList, selectedoilsdetails: transformedoil));
    print(state.selectedoils);
    selectedoil = null;
    print(selectedoil);

    qtyoilController.clear();
    focusNodeoil.unfocus();
  }

  void removeoil(String oilname) {
    final updatedoilList =
        List<Map<String, String>>.from(state.selectedoils ?? []);
    updatedoilList.removeWhere((item) => item['name'] == oilname);
    emit(state.copyWith(selectedoils: updatedoilList));
    print(state.selectedoils);
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  Future<void> getTractor() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetTractorModel response =
            await servicerepository.getTractorApi(requestData);
        emit(state.copyWith(gettractormodel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(AddServiceError(errorResponse['message']));
            return;
          } else {
            emit(AddServiceError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddServiceError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSparepartsApi() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetSparePartsModel response =
            await servicerepository.getsparepartsApi(requestData);
        emit(state.copyWith(spareparts: response));

        setRxRequestStatus(Status.COMPLETED);

        Utils.printLog("Response===> ${response.toString()}");
      } catch (error, stackTrace) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(AddServiceError(errorResponse['message']));
            return;
          } else {
            emit(AddServiceError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          Utils.printLog("Error===> ${stackTrace.toString()}}");
          emit(AddServiceError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getoilApi() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetOilModel response = await servicerepository.getoilApi(requestData);
        emit(state.copyWith(oilsnames: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(AddServiceError(errorResponse['message']));
            return;
          } else {
            emit(AddServiceError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddServiceError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> addSalesEntry(context) async {
    emit(AddServiceLoading());
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "tractorId": state.selectedTractor?.sId,
        "customerName":
            nameController.text.isNotEmpty ? nameController.text : "",
        "customerContact":
            contactController.text.isNotEmpty ? contactController.text : "",
        "customerAddress":
            addressController.text.isNotEmpty ? addressController.text : "",
        "serviceType": state.selectedservicetype,
        "serviceDescription": servicedescriptionController.text.isNotEmpty
            ? servicedescriptionController.text
            : "",
        "spareParts": state.selectedsparepartsdetails,
        "oils": state.selectedoilsdetails,
        "totalPartsCost":
            state.selectedsparepartsdetails?.fold(0.0, (sum, item) {
          double cost = item["cost"] is double
              ? item["cost"]
              : double.tryParse(item["cost"].toString()) ?? 0.0;
          return sum + cost;
        }),
        "totalOilsCost": state.selectedoilsdetails?.fold(0.0, (sum, item) {
          double cost = item["cost"] is double
              ? item["cost"]
              : double.tryParse(item["cost"].toString()) ?? 0.0;
          return sum + cost;
        }),
        "totalCost": ((state.selectedsparepartsdetails?.fold(0.0, (sum, item) {
                  double cost = item["cost"] is double
                      ? item["cost"]
                      : double.tryParse(item["cost"].toString()) ?? 0.0;
                  return sum + cost;
                }) ??
                0.0) +
            (state.selectedoilsdetails?.fold(0.0, (sum, item) {
                  double cost = item["cost"] is double
                      ? item["cost"]
                      : double.tryParse(item["cost"].toString()) ?? 0.0;
                  return sum ?? 0 + cost;
                }) ??
                0.0) +
            (double.tryParse(servicechargeController.text) ?? 0.0)),
        "serviceCost": double.parse(
          servicechargeController.text.isNotEmpty
              ? servicechargeController.text
              : "0",
        ),
        "paymentStatus": (((state.selectedsparepartsdetails?.fold(0.0,
                            (sum, item) {
                          double cost = item["cost"] is double
                              ? item["cost"]
                              : double.tryParse(item["cost"].toString()) ?? 0.0;
                          return sum + cost;
                        }) ??
                        0.0) +
                    (state.selectedoilsdetails?.fold(0.0, (sum, item) {
                          double cost = item["cost"] is double
                              ? item["cost"]
                              : double.tryParse(item["cost"].toString()) ?? 0.0;
                          return sum ?? 0 + cost;
                        }) ??
                        0.0) +
                    (double.tryParse(servicechargeController.text) ?? 0.0)) ==
                ((state.selectedsparepartsdetails?.fold(0.0, (sum, item) {
                              double cost = item["cost"] is double
                                  ? item["cost"]
                                  : double.tryParse(item["cost"].toString()) ??
                                      0.0;
                              return sum + cost;
                            }) ??
                            0.0) +
                        (state.selectedoilsdetails?.fold(0.0, (sum, item) {
                              double cost = item["cost"] is double
                                  ? item["cost"]
                                  : double.tryParse(item["cost"].toString()) ??
                                      0.0;
                              return sum ?? 0 + cost;
                            }) ??
                            0.0) +
                        (double.tryParse(servicechargeController.text) ??
                            0.0)) -
                    (double.tryParse(paidAmountController.text) ?? 0.0))
            ? "Pending"
            : (((state.selectedsparepartsdetails?.fold(0.0, (sum, item) {
                                  double cost = item["cost"] is double
                                      ? item["cost"]
                                      : double.tryParse(
                                              item["cost"].toString()) ??
                                          0.0;
                                  return sum + cost;
                                }) ??
                                0.0) +
                            (state.selectedoilsdetails?.fold(0.0, (sum, item) {
                                  double cost = item["cost"] is double
                                      ? item["cost"]
                                      : double.tryParse(
                                              item["cost"].toString()) ??
                                          0.0;
                                  return sum ?? 0 + cost;
                                }) ??
                                0.0) +
                            (double.tryParse(servicechargeController.text) ??
                                0.0)) -
                        (double.tryParse(paidAmountController.text) ?? 0.0)) ==
                    0.00
                ? "Paid"
                : "Partially Paid",
        "paidAmount": double.parse(
          paidAmountController.text.isNotEmpty
              ? paidAmountController.text
              : "0",
        ),
        "dueAmount": (((state.selectedsparepartsdetails?.fold(0.0, (sum, item) {
                      double cost = item["cost"] is double
                          ? item["cost"]
                          : double.tryParse(item["cost"].toString()) ?? 0.0;
                      return sum + cost;
                    }) ??
                    0.0) +
                (state.selectedoilsdetails?.fold(0.0, (sum, item) {
                      double cost = item["cost"] is double
                          ? item["cost"]
                          : double.tryParse(item["cost"].toString()) ?? 0.0;
                      return sum ?? 0 + cost;
                    }) ??
                    0.0) +
                (double.tryParse(servicechargeController.text) ?? 0.0)) -
            (double.tryParse(paidAmountController.text) ?? 0.0)),
        "paymentMethod": state.paymentmethod,
      };

      try {
        AddServiceEntryModel response =
            await servicerepository.addServiceEntryApi(requestData);
        emit(state.copyWith(addServiceEntryModel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        emit(AddServiceSuccess("Successfully Add Entry..."));
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(AddServiceError(errorResponse['message']));
            return;
          } else {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(AddServiceError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddServiceError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }
}
