import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_spareparts_state.dart';

class AddSpareCubit extends Cubit<AddSpareState> {
  AddSpareCubit()
      : super(AddSpareState(spareparts: [
          "Clutch Plate",
          "Brake Disc",
          "Oil Filter",
          "Fuel Injector",
          "Gear Box",
          "ElectricoMagnetic Clutch",
          "Volvo",
          "Pillow Block",
        ], selectedspareparts: []));

  String? selectedPart;
  final TextEditingController qtyController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void updateSparePart(String partName, String quantity) {
    final updatedList =
        List<Map<String, String>>.from(state.selectedspareparts ?? []);

    final existingIndex =
        updatedList.indexWhere((item) => item['name'] == partName);

    if (existingIndex != -1) {
      updatedList[existingIndex]['quantity'] = quantity;
    } else {
      updatedList.add({'name': partName, 'quantity': quantity});
    }
    emit(state.copyWith(selectedspareparts: updatedList));
    print(state.selectedspareparts);
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
}
