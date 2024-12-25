import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/add_sale_entry_cubit/add_sale_state.dart';
import 'package:savitri_automobiles_admin/modules/model/addsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class AddSaleCubit extends Cubit<AddSaleState> {
  final SalesRepository salesrepository = SalesRepository();
  AddSaleCubit() : super(AddSaleLoading()) {
    getTractor();
    getImplements();
  }

  // TextEditingControllers for fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final TextEditingController exchangemodelController = TextEditingController();
  final TextEditingController exchangebrandController = TextEditingController();
  final TextEditingController exchangevehicleTypeController =
      TextEditingController();
  final TextEditingController exchangevehicleamountController =
      TextEditingController();
  final TextEditingController exchangevehicleageController =
      TextEditingController();
  final TextEditingController exchangedescriptionController =
      TextEditingController();

  final TextEditingController insuranceProviderController =
      TextEditingController();
  final TextEditingController insuranceCostController = TextEditingController();
  final TextEditingController registrationCostController =
      TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController transportationCostController =
      TextEditingController();
  final TextEditingController financeamountController = TextEditingController();

  var dropDownKey = GlobalKey<DropdownSearchState>();
  var dropDownKeyfinance = GlobalKey<DropdownSearchState>();
  var dropDownKeypaymentmethod = GlobalKey<DropdownSearchState>();
  var dropDownKeyRegistration = GlobalKey<DropdownSearchState>();

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

  void toggleExchangeItem(bool value) {
    emit(state.copyWith(isChecked: value));
  }

  void selectRegistrationType(String? type) {
    print("object1 $type");
    print("object2 $type");
    emit(state.copyWith(registrationType: type));
  }

  void selectFinanceTenure(String? year) {
    print("object1 $year");
    print("object2 $year");
    emit(state.copyWith(finance: year));
  }

  void selectpaymentMethod(String? type) {
    print("object1 $type");
    print("object2 $type");
    emit(state.copyWith(paymentmethod: type));
  }

  void updateSelectedEquipments(List<String> selected) {
    emit(state.copyWith(selectedEquipments: selected));
  }

  void setError(String value) => error = value;
  String error = '';

  var isLoading = false;
  var rxRequestStatus = Status.COMPLETED;

  void setRxRequestStatus(Status value) => rxRequestStatus = value;

  var addsalesentryModel = AddSalesEntryModel();

  void setAddSalesEntrydata(AddSalesEntryModel value) =>
      addsalesentryModel = value;

  Future<void> getTractor() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetTractorModel response =
            await salesrepository.getTractorApi(requestData);
        emit(state.copyWith(gettractormodel: response));

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(AddSaleError(errorResponse['message']));
            return;
          } else {
            emit(AddSaleError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddSaleError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddSaleError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getImplements() async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {"page": 1, "pageSize": 20};

      try {
        GetImplementModel response =
            await salesrepository.getImplementApi(requestData);
        emit(state.copyWith(getimplementmodel: response));

        setRxRequestStatus(Status.COMPLETED);

        Utils.printLog("Response===> ${response.toString()}");
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            emit(AddSaleError(errorResponse['message']));
            return;
          } else {
            emit(AddSaleError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddSaleError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddSaleError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> addSalesEntry(context) async {
    await Future.delayed(const Duration(seconds: 2));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "tractorId": state.selectedTractormodel,
        "equipments": state.selectedEquipments,
        "customerName": nameController.text,
        "customerContact": contactController.text,
        "customerAddress": addressController.text,
        "isExchange": state.isChecked,
        if (state.isChecked ?? false)
          "exchangeItem": {
            "amount": state.isChecked ?? false
                ? double.parse(exchangevehicleamountController.text.isNotEmpty
                    ? exchangevehicleamountController.text
                    : "0")
                : 0,
            "description": state.isChecked ?? false
                ? exchangedescriptionController.text
                : null,
            "model":
                state.isChecked ?? false ? exchangemodelController.text : null,
            "brand":
                state.isChecked ?? false ? exchangebrandController.text : null,
            "vehicleType": state.isChecked ?? false
                ? exchangevehicleTypeController.text
                : null,
            "vehicleAge": state.isChecked ?? false
                ? int.parse(exchangevehicleageController.text.isNotEmpty
                    ? exchangevehicleageController.text
                    : "0")
                : 0,
          },
        "paymentMethod": state.paymentmethod,
        "paidAmount": double.parse(paidAmountController.text.isNotEmpty
            ? paidAmountController.text
            : "0"),
        "registration": {
          "registrationType": state.registrationType,
          "registrationCost": double.parse(
              registrationCostController.text.isNotEmpty
                  ? registrationCostController.text
                  : "0")
        },
        "insurance": {
          "insuranceProvider": insuranceProviderController.text,
          "insuranceCost": double.parse(insuranceCostController.text.isNotEmpty
              ? insuranceCostController.text
              : "0")
        },
        "transportationCost": double.parse(
            transportationCostController.text.isNotEmpty
                ? transportationCostController.text
                : "0"),
        "finance": {
          "amount": double.parse(financeamountController.text.isNotEmpty
              ? financeamountController.text
              : "0"),
          "tenure": state.finance
        }
      };

      try {
        AddSalesEntryModel response =
            await salesrepository.addSalesEntryApi(requestData);
        emit(state.copyWith(addSalesEntryModel: response));
        Navigator.pushReplacementNamed(
          context,
          Routes.reviewSalesEntry,
          arguments: state.addSalesEntryModel?.data?.id ?? "",
        );

        setRxRequestStatus(Status.COMPLETED);
        setAddSalesEntrydata(response);
        Utils.printLog("Response===> ${response.toString()}");
        emit(AddSaleSuccess("Successfully Add Entry..."));
      } catch (error) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(AddSaleError(errorResponse['message']));
            return;
          } else {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
            emit(AddSaleError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(AddSaleError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(AddSaleError(appStrings.weUnableCheckData));
      return;
    }
  }
}
