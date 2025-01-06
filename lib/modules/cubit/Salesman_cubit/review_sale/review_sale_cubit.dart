import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/commonmethods.dart';
import 'package:savitri_automobiles_admin/data/response/status.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Salesman_cubit/review_sale/review_sale_state.dart';
import 'package:savitri_automobiles_admin/modules/model/addsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final SalesRepository salesrepository = SalesRepository();
  ReviewCubit(Map<String, dynamic>? salesEntryData) : super(ReviewLoading()) {
    initializeSalesEntryData(salesEntryData);
    print(salesEntryData);
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
          selectedTractor: selectedTractor,
          tractorprice: selectedTractor.price ?? 0));
    } else {
      print("No tractor found with ID: $id");
    }
  }

  void toggleExchangeItem(bool value) {
    emit(state.copyWith(isChecked: value));
  }

  void tractoreditcheck(bool value) {
    emit(state.copyWith(tractoreditcheck: value));
  }

  void customereditcheck(bool value) {
    emit(state.copyWith(customereditcheck: value));
  }

  void exhangeeditcheck(bool value) {
    emit(state.copyWith(exhangeeditcheck: value));
  }

  void registrationeditcheck(bool value) {
    emit(state.copyWith(registrationeditcheck: value));
  }

  void equipmenteditcheck(bool value) {
    emit(state.copyWith(equipmenteditcheck: value));
  }

  void insuranceeditcheck(bool value) {
    emit(state.copyWith(insuranceeditcheck: value));
  }

  void financeeditcheck(bool value) {
    emit(state.copyWith(financeeditcheck: value));
  }

  void transportationeditcheck(bool value) {
    emit(state.copyWith(transportationeditcheck: value));
  }

  void paymenteditcheck(bool value) {
    emit(state.copyWith(paymenteditcheck: value));
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
    emit(state.copyWith(finance: type));
  }

  void selectedregistrationcost(int? value) {
    print("object1 $value");
    emit(state.copyWith(registrationprice: value));
  }

  void selectedequipmentcost(int? value) {
    print("object1 $value");
    emit(state.copyWith(implementprice: value));
  }

  void selectedinsurancecost(int? value) {
    print("object1 $value");
    emit(state.copyWith(insuranceprice: value));
  }

  void selectedexchangecost(int? value) {
    print("object1 $value");
    emit(state.copyWith(exchangeprice: value));
  }

  void selectedfinancecost(int? value) {
    print("object1 $value");
    emit(state.copyWith(financeprice: value));
  }

  void selectedtransportationcost(int? value) {
    print("object1 $value");
    emit(state.copyWith(transportationprice: value));
  }

  void paidAmount(int? value) {
    print("object1 $value");
    emit(state.copyWith(paidamount: value));
  }

  void updateSelectedEquipments(List<String> selected) {
    emit(state.copyWith(selectedEquipments: selected));
  }

  void selectedequipmentname(List<String>? value) {
    print("object1 $value");
    emit(state.copyWith(selectedEquipmentsname: value));
  }

  void selectedequipmentprice(List<int>? value) {
    print("object1 $value");
    emit(state.copyWith(selectedEquipmentsprice: value));
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
            emit(ReviewError(errorResponse['message']));
            return;
          } else {
            emit(ReviewError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ReviewError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ReviewError(appStrings.weUnableCheckData));
      return;
    }
  }

  Future<void> getImplements() async {
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
            emit(ReviewError(errorResponse['message']));
            return;
          } else {
            emit(ReviewError("An unexpected error occurred."));
            return;
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          emit(ReviewError("${error.toString()} Login failed..."));
          return;
        }
      }
    } else {
      emit(ReviewError(appStrings.weUnableCheckData));
      return;
    }
  }

  void initializeSalesEntryData(Map<String, dynamic>? salesEntryData) {
    if (salesEntryData == null) return;

    // Set TextEditingController values
    nameController.text = salesEntryData['name'] ?? "";
    contactController.text = salesEntryData['contact'] ?? "";
    addressController.text = salesEntryData['address'] ?? "";
    exchangemodelController.text = salesEntryData['exchangeModel'] ?? "";
    exchangebrandController.text = salesEntryData['exchangeBrand'] ?? "";
    exchangevehicleTypeController.text =
        salesEntryData['exchangeVehicleType'] ?? "";
    exchangevehicleamountController.text =
        (salesEntryData['exchangeVehicleAmount']);
    exchangevehicleageController.text = (salesEntryData['exchangeVehicleAge']);
    exchangedescriptionController.text =
        salesEntryData['exchangeDescription'] ?? "";
    insuranceProviderController.text =
        salesEntryData['insuranceProvider'] ?? "";
    insuranceCostController.text = (salesEntryData['insuranceCost']);
    registrationCostController.text = (salesEntryData['registrationCost']);
    paidAmountController.text = (salesEntryData['paidAmount']);
    transportationCostController.text = (salesEntryData['transportationCost']);
    financeamountController.text = (salesEntryData['financeAmount']);

    // Emit state updates for other properties if using state management
    emit(state.copyWith(
      selectedEquipments:
          (salesEntryData['selectedEquipments'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
      selectedEquipmentsname:
          (salesEntryData['selectedEquipmentsname'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
      selectedEquipmentsprice:
          (salesEntryData['selectedEquipmentsprice'] as List<dynamic>?)
                  ?.map((e) => int.tryParse(e.toString()) ?? 0)
                  .toList() ??
              [],
      isChecked: salesEntryData['isChecked'] ?? false,
      selectedTractormodel: salesEntryData['selectedTractorModel'] ?? "",
      finance: salesEntryData['finance'],
      paymentmethod: salesEntryData['paymentMethod'],
      registrationType: salesEntryData['registrationType'],
      gettractormodel: salesEntryData["getTractorModel"],
      getimplementmodel: salesEntryData["getImplementModel"],
      selectedTractor: salesEntryData["selectedTractor"],
      totalprice: salesEntryData["totalPrice"],
      tractorprice: salesEntryData["tractorPrice"],
      implementprice: salesEntryData["implementPrice"],
      exchangeprice: salesEntryData["exchangePrice"],
      paidamount: salesEntryData["paidAmountCost"],
      insuranceprice: salesEntryData["insurancePrice"],
      registrationprice: salesEntryData["registrationPrice"],
      transportationprice: salesEntryData["transportationPrice"],
      financeprice: salesEntryData["financePrice"],
    ));

    // Debugging logs
    Utils.printLog("Customer Name: ${nameController.text}");
    Utils.printLog("Customer Contact: ${contactController.text}");
    Utils.printLog("Selected Equipments: ${state.selectedEquipments}");
    Utils.printLog("Is Exchange Checked: ${state.isChecked}");
    Utils.printLog("Selected Tractor Model: ${state.selectedTractormodel}");
    Utils.printLog("Finance Tenure: ${state.finance}");
    Utils.printLog("Payment Method: ${state.paymentmethod}");
    Utils.printLog("Registration Type: ${state.registrationType}");
  }

  Future<void> addSalesEntry(context) async {
    final currentState = state;
    emit(ReviewSaleLoading(
      gettractormodel: currentState.gettractormodel,
      getimplementmodel: currentState.getimplementmodel,
      selectedTractor: currentState.selectedTractor,
      selectedTractormodel: currentState.selectedTractormodel,
      selectedEquipments: currentState.selectedEquipments,
      selectedEquipmentsname: currentState.selectedEquipmentsname,
      selectedEquipmentsprice: currentState.selectedEquipmentsprice,
      isChecked: currentState.isChecked,
      registrationType: currentState.registrationType,
      paymentmethod: currentState.paymentmethod,
      finance: currentState.finance,
      isLoading: currentState.isLoading,
      isSuccess: currentState.isSuccess,
      message: currentState.message,
      tractoreditcheck: currentState.tractoreditcheck,
      customereditcheck: currentState.customereditcheck,
      exhangeeditcheck: currentState.exhangeeditcheck,
      registrationeditcheck: currentState.registrationeditcheck,
      equipmenteditcheck: currentState.equipmenteditcheck,
      insuranceeditcheck: currentState.insuranceeditcheck,
      financeeditcheck: currentState.financeeditcheck,
      transportationeditcheck: currentState.transportationeditcheck,
      paymenteditcheck: currentState.paymenteditcheck,
      totalprice: currentState.totalprice ?? 0,
      paidamount: currentState.paidamount ?? 0,
      tractorprice: currentState.tractorprice ?? 0,
      implementprice: currentState.implementprice ?? 0,
      exchangeprice: currentState.exchangeprice ?? 0,
      insuranceprice: currentState.insuranceprice ?? 0,
      registrationprice: currentState.registrationprice ?? 0,
      transportationprice: currentState.transportationprice ?? 0,
      financeprice: currentState.financeprice ?? 0,
    ));

    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      print(
          "total Price${((state.tractorprice ?? 0.0) + (state.registrationprice ?? 0.0) + (state.implementprice ?? 0.0) + (state.insuranceprice ?? 0.0) - (state.financeprice ?? 0.0) + (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) + (state.transportationprice ?? 0.0))}");

      Map<String, dynamic> requestData = {
        "totalAmount": ((state.tractorprice ?? 0.0) +
            (state.registrationprice ?? 0.0) +
            (state.implementprice ?? 0.0) +
            (state.insuranceprice ?? 0.0) -
            (state.financeprice ?? 0.0) +
            (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) +
            (state.transportationprice ?? 0.0)),
        "tractorId": state.selectedTractormodel,
        if (state.selectedEquipments?.isNotEmpty ?? false)
          "equipments": state.selectedEquipments,
        if (nameController.text.isNotEmpty) "customerName": nameController.text,
        if (contactController.text.isNotEmpty)
          "customerContact": contactController.text,
        if (addressController.text.isNotEmpty)
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
        if (state.paymentmethod?.isNotEmpty ?? false)
          "paymentMethod": state.paymentmethod,
        if (paidAmountController.text.isNotEmpty)
          "paidAmount": double.parse(paidAmountController.text.isNotEmpty
              ? paidAmountController.text
              : "0"),
        "dueAmount": (state.tractorprice ?? 0.0) +
            (state.registrationprice ?? 0.0) +
            (state.implementprice ?? 0.0) +
            (state.insuranceprice ?? 0.0) -
            (state.financeprice ?? 0.0) +
            (state.isChecked == true ? -(state.exchangeprice ?? 0.0) : 0) +
            (state.transportationprice ?? 0.0) -
            (state.paidamount ?? 0),
        if (registrationCostController.text.isNotEmpty &&
            (state.registrationType?.isNotEmpty ?? false))
          "registration": {
            "registrationType": state.registrationType,
            "registrationCost": double.parse(
                registrationCostController.text.isNotEmpty
                    ? registrationCostController.text
                    : "0")
          },
        if (insuranceCostController.text.isNotEmpty &&
            (insuranceProviderController.text.isNotEmpty))
          "insurance": {
            "insuranceProvider": insuranceProviderController.text,
            "insuranceCost": double.parse(
                insuranceCostController.text.isNotEmpty
                    ? insuranceCostController.text
                    : "0")
          },
        if (transportationCostController.text.isNotEmpty)
          "transportationCost": double.parse(
              transportationCostController.text.isNotEmpty
                  ? transportationCostController.text
                  : "0"),
        if (financeamountController.text.isNotEmpty &&
            (state.finance?.isNotEmpty ?? false))
          "finance": {
            "amount": double.parse(financeamountController.text.isNotEmpty
                ? financeamountController.text
                : "0"),
            "tenure": state.finance
          },
      };

      try {
        AddSalesEntryModel response =
            await salesrepository.addSalesEntryApi(requestData);

        setRxRequestStatus(Status.COMPLETED);
        Utils.printLog("Response===> ${response.toString()}");
        emit(ReviewSuccess("Successfully Add Entry..."));
      } catch (error, stackTrace) {
        setRxRequestStatus(Status.ERROR);
        setError(error.toString());

        if (error.toString().contains("{")) {
          var errorResponse = json.decode(error.toString());
          if (errorResponse is Map && errorResponse.containsKey('message')) {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
          } else {
            Utils.printLog("errorResponse===> ${errorResponse['message']}");
          }
        } else {
          Utils.printLog("Error===> ${error.toString()}");
          Utils.printLog("Error===> ${stackTrace.toString()}");
        }
      }
    } else {
      emit(ReviewError(appStrings.weUnableCheckData));
      return;
    }
  }
}
