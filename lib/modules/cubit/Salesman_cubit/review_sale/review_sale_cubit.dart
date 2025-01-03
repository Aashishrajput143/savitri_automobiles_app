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
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';
import 'package:savitri_automobiles_admin/modules/repository/Sales_repository.dart';
import 'package:savitri_automobiles_admin/resources/strings.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final SalesRepository salesrepository = SalesRepository();
  ReviewCubit(String id) : super(ReviewLoading()) {
    getTractor();
    getImplements();
    print(id);
    getDetailsData(id);
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

  int dueamount(total, paid, finance) {
    return total - (paid + finance);
  }

  int calculateTotalAmount(state, cubit) {
    int registrationCost = int.parse(
        cubit.registrationCostController.text.isNotEmpty
            ? cubit.registrationCostController.text
            : "0");
    int insuranceCost = int.parse(cubit.insuranceCostController.text.isNotEmpty
        ? cubit.insuranceCostController.text
        : "0");
    int transportationCost = int.parse(
        cubit.transportationCostController.text.isNotEmpty
            ? cubit.transportationCostController.text
            : "0");
    int exchangeVehicleCost = state.isChecked ?? false
        ? int.parse(cubit.exchangevehicleamountController.text.isNotEmpty
            ? cubit.exchangevehicleamountController.text
            : "0")
        : 0;

    // Base price of the tractor
    int tractorPrice = state.selectedTractor?.price ??
        state.getSalesEntryDetailsModel?.data?.tractorBasePrice ??
        0;

    // Calculate the sum of equipment costs
    int equipmentCost = 0;
    if (state.getSalesEntryDetailsModel?.data?.equipments != null) {
      equipmentCost = state.getSalesEntryDetailsModel!.data!.equipments!
          .fold(0, (sum, equipment) => sum + (equipment.price ?? 0));
    }

    // Calculate the total amount
    int totalAmount = tractorPrice +
        equipmentCost +
        registrationCost +
        insuranceCost +
        transportationCost -
        exchangeVehicleCost;

    return totalAmount;
  }

  int calculateTotalAmountcubit(state) {
    int registrationCost = int.parse(registrationCostController.text.isNotEmpty
        ? registrationCostController.text
        : "0");
    int insuranceCost = int.parse(insuranceCostController.text.isNotEmpty
        ? insuranceCostController.text
        : "0");
    int transportationCost = int.parse(
        transportationCostController.text.isNotEmpty
            ? transportationCostController.text
            : "0");
    int exchangeVehicleCost = state.isChecked ?? false
        ? int.parse(exchangevehicleamountController.text.isNotEmpty
            ? exchangevehicleamountController.text
            : "0")
        : 0;

    // Base price of the tractor
    int tractorPrice = state.selectedTractor?.price ??
        state.getSalesEntryDetailsModel?.data?.tractorBasePrice ??
        0;

    // Calculate the sum of equipment costs
    int equipmentCost = 0;
    if (state.getSalesEntryDetailsModel?.data?.equipments != null) {
      equipmentCost = state.getSalesEntryDetailsModel!.data!.equipments!
          .fold(0, (sum, equipment) => sum + (equipment.price ?? 0));
    }

    // Calculate the total amount
    int totalAmount = tractorPrice +
        equipmentCost +
        registrationCost +
        insuranceCost +
        transportationCost -
        exchangeVehicleCost;

    return totalAmount;
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

  void updateSelectedEquipments(List<String> selected) {
    print(selected);
    List<String> names = [];
    List<String> prices = [];
    List<String> id = [];

    for (var item in selected) {
      List<String> parts = item.split(',');
      if (parts.length >= 3) {
        id.add(parts[0]);
        names.add(parts[1]);
        prices.add(parts[2]);
      }
    }
    emit(state.copyWith(
        selectedEquipments: id,
        selectedEquipmentsname: names,
        selectedEquipmentsprice: prices));
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

  Future<void> addSalesEntry(context, total) async {
    final currentState = state;
    emit(ReviewSaleLoading(
      gettractormodel: currentState.gettractormodel,
      getimplementmodel: currentState.getimplementmodel,
      getSalesEntryDetailsModel: currentState.getSalesEntryDetailsModel,
      selectedTractor: currentState.selectedTractor,
      selectedTractormodel: currentState.selectedTractormodel,
      selectedEquipments: currentState.selectedEquipments,
      isChecked: currentState.isChecked,
      registrationType: currentState.registrationType,
      paymentmethod: currentState.paymentmethod,
      finance: currentState.finance,
    ));
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);

      Map<String, dynamic> requestData = {
        "totalAmount": total,
        "id": state.getSalesEntryDetailsModel?.data?.sId,
        "tractorId": state.selectedTractormodel?.isEmpty ??
            state.getSalesEntryDetailsModel?.data?.tractor?.sId,
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
        "dueAmount": dueamount(
            calculateTotalAmountcubit(state),
            int.parse(paidAmountController.text.isNotEmpty
                ? paidAmountController.text
                : "0"),
            int.parse(financeamountController.text.isNotEmpty
                ? financeamountController.text
                : "0")),
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
        "publishStatus": "PUBLISH"
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

  // void setData() {
  //   print("object");
  //   if (state.getSalesEntryDetailsModel?.data?.customerName?.isNotEmpty ??
  //       false) {
  //     nameController.text =
  //         state.getSalesEntryDetailsModel?.data?.customerName ?? "";
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.customerContact?.isNotEmpty ??
  //       false) {
  //     contactController.text =
  //         state.getSalesEntryDetailsModel?.data?.customerContact ?? "";
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.customerAddress?.isNotEmpty ??
  //       false) {
  //     addressController.text =
  //         state.getSalesEntryDetailsModel?.data?.customerAddress ?? "";
  //   }
  //   if (state
  //           .getSalesEntryDetailsModel?.data?.exchangeItem?.model?.isNotEmpty ??
  //       false) {
  //     exchangemodelController.text =
  //         state.getSalesEntryDetailsModel?.data?.exchangeItem?.model ?? "";
  //   }
  //   if (state
  //           .getSalesEntryDetailsModel?.data?.exchangeItem?.brand?.isNotEmpty ??
  //       false) {
  //     exchangebrandController.text =
  //         state.getSalesEntryDetailsModel?.data?.exchangeItem?.brand ?? "";
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleType
  //           ?.isNotEmpty ??
  //       false) {
  //     exchangevehicleTypeController.text =
  //         state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleType ??
  //             "";
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.exchangeItem?.amount != null) {
  //     exchangevehicleamountController.text =
  //         (state.getSalesEntryDetailsModel?.data?.exchangeItem?.amount ?? 0)
  //             .toString();
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleAge !=
  //       null) {
  //     exchangevehicleageController.text =
  //         (state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleAge ?? 0)
  //             .toString();
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.exchangeItem?.description
  //           ?.isNotEmpty ??
  //       false) {
  //     exchangedescriptionController.text =
  //         state.getSalesEntryDetailsModel?.data?.exchangeItem?.description ??
  //             "";
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.insurance?.insuranceProvider
  //           ?.isNotEmpty ??
  //       false) {
  //     insuranceProviderController.text =
  //         state.getSalesEntryDetailsModel?.data?.insurance?.insuranceProvider ??
  //             "";
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.insurance?.insuranceCost !=
  //       null) {
  //     insuranceCostController.text =
  //         (state.getSalesEntryDetailsModel?.data?.insurance?.insuranceCost ?? 0)
  //             .toString();
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.registration?.registrationCost !=
  //       null) {
  //     registrationCostController.text = (state.getSalesEntryDetailsModel?.data
  //                 ?.registration?.registrationCost ??
  //             0)
  //         .toString();
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.paidAmount != null) {
  //     paidAmountController.text =
  //         (state.getSalesEntryDetailsModel?.data?.paidAmount ?? 0).toString();
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.transportationCost != null) {
  //     transportationCostController.text =
  //         (state.getSalesEntryDetailsModel?.data?.transportationCost ?? 0)
  //             .toString();
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.finance?.amount != null) {
  //     financeamountController.text =
  //         (state.getSalesEntryDetailsModel?.data?.finance?.amount ?? 0)
  //             .toString();
  //   }

  //   financeamountController.text =
  //       (state.getSalesEntryDetailsModel?.data?.finance?.amount ?? 0)
  //           .toString();

  //   if (state.getSalesEntryDetailsModel?.data?.equipments?.isNotEmpty ??
  //       false) {
  //     emit(state.copyWith(
  //         selectedEquipments: state.getSalesEntryDetailsModel?.data?.equipments
  //                 ?.map((equipment) => equipment.sId.toString())
  //                 .toList() ??
  //             []));
  //   }

  //   print("sekeslkfnsnfks===========${state.selectedEquipments}");
  //   print(
  //       "sekeslkfnsnsfdsfsdfks===========${state.getSalesEntryDetailsModel?.data?.equipments?.map((equipment) => equipment.sId.toString()).toList() ?? []}");

  //   if (state.getSalesEntryDetailsModel?.data?.isExchange ?? false) {
  //     emit(state.copyWith(
  //         isChecked:
  //             state.getSalesEntryDetailsModel?.data?.isExchange ?? false));
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.tractor?.modelName?.isNotEmpty ??
  //       false) {
  //     emit(state.copyWith(
  //         selectedTractormodel:
  //             state.getSalesEntryDetailsModel?.data?.tractor?.modelName ?? ""));
  //   }
  //   if (state.getSalesEntryDetailsModel?.data?.finance?.tenure?.isNotEmpty ??
  //       false) {
  //     emit(state.copyWith(
  //         finance:
  //             state.getSalesEntryDetailsModel?.data?.finance?.tenure ?? ""));
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.paymentMethod?.isNotEmpty ??
  //       false) {
  //     emit(state.copyWith(
  //         paymentmethod:
  //             state.getSalesEntryDetailsModel?.data?.paymentMethod ?? ""));
  //   }

  //   if (state.getSalesEntryDetailsModel?.data?.registration?.registrationType
  //           ?.isNotEmpty ??
  //       false) {
  //     emit(state.copyWith(
  //         registrationType: state.getSalesEntryDetailsModel?.data?.registration
  //                 ?.registrationType ??
  //             ""));
  //   }

  //   Utils.printLog("Customer Name: ${nameController.text}");
  //   Utils.printLog("Customer Contact: ${contactController.text}");
  // }

  Future<void> getDetailsData(var id) async {
    bool connection = await CommonMethods.checkInternetConnectivity();
    Utils.printLog("CheckInternetConnection===> ${connection.toString()}");

    if (connection) {
      setRxRequestStatus(Status.LOADING);
      try {
        GetSalesEntryDetailsModel response =
            await salesrepository.getSalesEntriesDetails(id);

        emit(state.copyWith(getSalesEntryDetailsModel: response));
        print("dfsdsfsdfs");
        nameController.text =
            state.getSalesEntryDetailsModel?.data?.customerName ?? "";

        contactController.text =
            state.getSalesEntryDetailsModel?.data?.customerContact ?? "";

        addressController.text =
            state.getSalesEntryDetailsModel?.data?.customerAddress ?? "";

        exchangemodelController.text =
            state.getSalesEntryDetailsModel?.data?.exchangeItem?.model ?? "";

        exchangebrandController.text =
            state.getSalesEntryDetailsModel?.data?.exchangeItem?.brand ?? "";

        exchangevehicleTypeController.text =
            state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleType ??
                "";

        exchangevehicleamountController.text =
            (state.getSalesEntryDetailsModel?.data?.exchangeItem?.amount ?? 0)
                .toString();

        exchangevehicleageController.text =
            (state.getSalesEntryDetailsModel?.data?.exchangeItem?.vehicleAge ??
                    0)
                .toString();
        print("dfsdsfsdfs");
        exchangedescriptionController.text =
            state.getSalesEntryDetailsModel?.data?.exchangeItem?.description ??
                "";

        insuranceProviderController.text = state.getSalesEntryDetailsModel?.data
                ?.insurance?.insuranceProvider ??
            "";

        insuranceCostController.text =
            (state.getSalesEntryDetailsModel?.data?.insurance?.insuranceCost ??
                    0)
                .toString();

        registrationCostController.text = (state.getSalesEntryDetailsModel?.data
                    ?.registration?.registrationCost ??
                0)
            .toString();

        paidAmountController.text =
            (state.getSalesEntryDetailsModel?.data?.paidAmount ?? 0).toString();

        transportationCostController.text =
            (state.getSalesEntryDetailsModel?.data?.transportationCost ?? 0)
                .toString();
        print("dfsdsfsdfs");
        financeamountController.text =
            (state.getSalesEntryDetailsModel?.data?.finance?.amount ?? 0)
                .toString();

        financeamountController.text =
            (state.getSalesEntryDetailsModel?.data?.finance?.amount ?? 0)
                .toString();

        emit(state.copyWith(
            selectedEquipments: state
                    .getSalesEntryDetailsModel?.data?.equipments
                    ?.map((equipment) => equipment.sId.toString())
                    .toList() ??
                []));

        print("sekeslkfnsnfks===========${state.selectedEquipments}");
        print(
            "sekeslkfnsnsfdsfsdfks===========${state.getSalesEntryDetailsModel?.data?.equipments?.map((equipment) => equipment.sId.toString()).toList() ?? []}");

        emit(state.copyWith(
            isChecked:
                state.getSalesEntryDetailsModel?.data?.isExchange ?? false));

        emit(state.copyWith(
            selectedTractormodel:
                state.getSalesEntryDetailsModel?.data?.tractor?.modelName ??
                    ""));
        print("dfsdsfsdfs");
        emit(state.copyWith(
            finance:
                state.getSalesEntryDetailsModel?.data?.finance?.tenure ?? ""));

        emit(state.copyWith(
            paymentmethod:
                state.getSalesEntryDetailsModel?.data?.paymentMethod ?? ""));

        emit(state.copyWith(
            registrationType: state.getSalesEntryDetailsModel?.data
                    ?.registration?.registrationType ??
                ""));
        print("dfsdsfsdfs");
        Utils.printLog("Customer Name: ${nameController.text}");
        Utils.printLog("Customer Contact: ${contactController.text}");

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
}
