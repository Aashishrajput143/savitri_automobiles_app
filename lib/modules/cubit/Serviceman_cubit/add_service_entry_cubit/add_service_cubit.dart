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
      print("Selected Tractor: ${selectedTractor.sId}");

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

  void totalserviceamount(int value) {
    print("object1 $value");
    emit(state.copyWith(servicechargeamount: value));
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
      int currentQuantity =
          int.tryParse(updatedList[existingIndex]['quantity'] ?? "0") ?? 0;

      int updatedQuantity = currentQuantity + (int.tryParse(quantity) ?? 0);

      updatedList[existingIndex]['quantity'] = updatedQuantity.toString();
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

    double totalPrice = transformedparts.fold(0.0, (sum, item) {
      double cost = item["cost"] is double
          ? item["cost"]
          : double.tryParse(item["cost"].toString()) ?? 0.0;

      int quantity = item["quantity"] is int
          ? item["quantity"]
          : int.tryParse(item["quantity"].toString()) ?? 0;

      return sum + (cost * quantity);
    });

    print("Total Price: $totalPrice");

    print(transformedparts);
    selectedPart = null;
    emit(state.copyWith(
        selectedspareparts: updatedList,
        selectedsparepartsdetails: transformedparts,
        totalsparepartsprice: totalPrice));

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
      int currentQuantity =
          int.tryParse(updatedoilList[existingoilIndex]['quantity'] ?? "0") ??
              0;

      int updatedQuantity = currentQuantity + (int.tryParse(oilquantity) ?? 0);

      updatedoilList[existingoilIndex]['quantity'] = updatedQuantity.toString();
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

    double totalPrice = transformedoil.fold(0.0, (sum, item) {
      double cost = item["cost"] is double
          ? item["cost"]
          : double.tryParse(item["cost"].toString()) ?? 0.0;

      int quantity = item["quantity"] is int
          ? item["quantity"]
          : int.tryParse(item["quantity"].toString()) ?? 0;

      return sum + (cost * quantity);
    });

    emit(state.copyWith(
        selectedoils: updatedoilList,
        selectedoilsdetails: transformedoil,
        totaloilprice: totalPrice));

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
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getSparepartsApi() async {
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
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getoilApi() async {
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
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> addServiceEntry(context) async {
    final currentState = state;
    emit(AddServicesuccessLoading(
      selectedTractor: currentState.selectedTractor,
      servicechargeamount: currentState.servicechargeamount,
      totalsparepartsprice: currentState.totalsparepartsprice,
      totaloilprice: currentState.totaloilprice,
      spareparts: currentState.spareparts,
      selectedspareparts: currentState.selectedspareparts,
      selectedsparepartsdetails: currentState.selectedsparepartsdetails,
      oilsnames: currentState.oilsnames,
      selectedoilsdetails: currentState.selectedoilsdetails,
      selectedoils: currentState.selectedoils,
      selectedservicetype: currentState.selectedservicetype,
      isSuccess: currentState.isSuccess,
      message: currentState.message,
      paymentmethod: currentState.paymentmethod,
    ));
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
        if (servicedescriptionController.text.isNotEmpty)
          "serviceDescription": servicedescriptionController.text.isNotEmpty
              ? servicedescriptionController.text
              : "",
        if (state.selectedsparepartsdetails?.isNotEmpty ?? false)
          "spareParts": state.selectedsparepartsdetails,
        if (state.selectedoilsdetails?.isNotEmpty ?? false)
          "oils": state.selectedoilsdetails,
        if (state.totalsparepartsprice != null)
          "totalPartsCost": state.totalsparepartsprice,
        if (state.totaloilprice != null) "totalOilsCost": state.totaloilprice,
        "totalCost": ((state.totalsparepartsprice ?? 0.0) +
            (state.totaloilprice ?? 0.0) +
            (double.tryParse(servicechargeController.text) ?? 0.0)),
        "serviceCost": double.parse(
          servicechargeController.text.isNotEmpty
              ? servicechargeController.text
              : "0",
        ),
        "paymentStatus": (((state.totalsparepartsprice ?? 0.0) +
                    (state.totaloilprice ?? 0.0) +
                    (double.tryParse(servicechargeController.text) ?? 0.0)) ==
                ((state.totalsparepartsprice ?? 0.0) +
                        (state.totaloilprice ?? 0.0) +
                        (double.tryParse(servicechargeController.text) ??
                            0.0)) -
                    (double.tryParse(paidAmountController.text) ?? 0.0))
            ? "Pending"
            : (((state.totalsparepartsprice ?? 0.0) +
                            (state.totaloilprice ?? 0.0) +
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
        "dueAmount": (((state.totalsparepartsprice ?? 0.0) +
                (state.totaloilprice ?? 0.0) +
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
          emit(AddServiceError("${error.toString()} failed..."));
          return;
        }
      }
    } else {
      emit(AddServiceError(appStrings.weUnableCheckData));
      return;
    }
  }
}
