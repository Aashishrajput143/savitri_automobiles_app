import 'package:bloc/bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit()
      : super(AddServiceState(
            tractors: [
              {
                "name": "John Deere 5050D",
                "model": "5050D",
                "ptoHP": "42.9 HP",
                "gearBox": "8 Forward + 2 Reverse/12 Forward+ 3 Reverse",
                "breaks": "Dry Disc / oil Immersed (Brake)",
                "warranty": "6 years",
                "clutch": "single/Dual",
                "lifting Capacity": "2000 kg",
                "wheelDrive": "2 WD",
                "Engine Rated RPM": "2000",
                "Steering": "Mechanical/Power Steering",
                "number": "JD12345",
                "price": "500000",
              },
              {
                "name": "Mahindra 575 DI",
                "model": "575 DI",
                "gearBox": "8 Forward + 2 Reverse/12 Forward+ 3 Reverse",
                "breaks": "Dry Disc / oil Immersed (Brake)",
                "warranty": "6 years",
                "clutch": "single/Dual",
                "lifting Capacity": "2000 kg",
                "wheelDrive": "2 WD",
                "Engine Rated RPM": "2000",
                "Steering": "Mechanical/Power Steering",
                "number": "MH98765",
                "price": "450000",
              },
            ],
            availableEquipments: [
              "Harrow",
              "Baler",
              "Plough",
              "Cultivator",
              "Loader",
              "Sprayer",
              "harvester",
              "Seeder"
            ],
            equipmentPrices: {
              "Harrow": "25,000",
              "Baler": "25,000",
              "Plough": "25,000",
              "Cultivator": "25,000",
              "Loader": "25,000",
              "Sprayer": "25,000",
              "harvester": "25,000",
              "Seeder": "25,000"
            },
            spareparts: [
              "Clutch Plate",
              "Brake Disc",
              "Oil Filter",
              "Fuel Injector",
              "Gear Box",
              "ElectricoMagnetic Clutch",
              "Volvo",
              "Pillow Block",
            ],
            selectedEquipments: [],
            selectedTractor: null,
            isChecked: false,
            discountType: "In Percent(%)",
            registrationType: "AGRICULTURE"));

  // TextEditingControllers for fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController exchangeItemController = TextEditingController();
  final TextEditingController insuranceProviderController =
      TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController insuranceCostController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController registrationCostController =
      TextEditingController();
  final TextEditingController registrationNumberController =
      TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  final TextEditingController dueAmountController = TextEditingController();
  final TextEditingController loanInterestController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  var dropDownKey = GlobalKey<DropdownSearchState>();
  var dropDownKeyDiscount = GlobalKey<DropdownSearchState>();
  var dropDownKeyRegistration = GlobalKey<DropdownSearchState>();
  String? selectedPart;

  List<Map<String, String>> getTractors() {
    return state.tractors;
  }

  List<String> getSpareParts() {
    return state.spareparts;
  }

  void selectTractor(String? model) {
    if (model == null) return;

    final selected = state.tractors.firstWhere(
      (tractor) => tractor["model"] == model,
      orElse: () => {},
    );

    emit(state.copyWith(selectedTractor: selected.isEmpty ? null : selected));
  }

  void addEquipment(String equipment) {
    final updated = List<String>.from(state.selectedEquipments)..add(equipment);
    emit(state.copyWith(selectedEquipments: updated));
  }

  void removeEquipment(String equipment) {
    final updated = List<String>.from(state.selectedEquipments)
      ..remove(equipment);
    emit(state.copyWith(selectedEquipments: updated));
  }

  void toggleExchangeItem(bool value) {
    emit(state.copyWith(isChecked: value));
  }

  void selectDiscountType(String? type) {
    if (type == null) return;

    emit(state.copyWith(discountType: type));
  }

  void selectRegistrationType(String? type) {
    if (type == null) return;

    emit(state.copyWith(registrationType: type));
  }

  void updateSelectedEquipments(List<String> selected) {
    emit(state.copyWith(selectedEquipments: selected));
  }

  // Add sale logic
  void addSale() {
    final saleData = {
      "tractor": state.selectedTractor,
      "customerName": nameController.text,
      "contact": contactController.text,
      "email": emailController.text,
      "address": addressController.text,
      "exchangeItem": state.isChecked ? exchangeItemController.text : null,
      "paymentMethod": paymentMethodController.text,
      "paidAmount": paidAmountController.text,
      "dueAmount": dueAmountController.text,
      "loanInterest": loanInterestController.text,
      "discount": discountController.text,
      "discountType": state.discountType,
      "Spare Parts": state.selectedspareparts,
    };

    // Mock submission logic
    print("Sale Data: $saleData");

    // Perform any API call or logic for adding a sale here
  }
}
