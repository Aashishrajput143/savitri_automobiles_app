import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

part 'sales_entry_state.dart';

class SalesEntryCubit extends Cubit<SalesEntryState> {
  SalesEntryCubit() : super(const SalesEntryInitial());

  static final List<Map<String, dynamic>> tractorDetails = [
    {
      "id": 1,
      "image": AppImages.swaraj735FE,
      "name": "Swaraj 735FE",
      "model": "735FE",
      "price": 500000,
      "description": "A powerful tractor for farming."
    },
    {
      "id": 2,
      "image": AppImages.swaraj735XT,
      "name": "Swaraj 735XT",
      "model": "735XT",
      "price": 450000,
      "description": "Highly reliable and efficient."
    },
    {
      "id": 3,
      "image": AppImages.tractor735FEePS,
      "name": "Swaraj 735FEePS",
      "model": "735EePS",
      "price": 480000,
      "description": "Known for its great performance."
    },
  ];
  Future<void> fetchSalesEntries() async {
    try {
      emit(const SalesEntryLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(SalesEntrySuccess(
        message: "Sales entries fetched successfully!",
        salesEntryListing: tractorDetails,
      ));
    } catch (error) {
      emit(const SalesEntrySuccess(
        message: "Failed to fetch sales entries.",
        salesEntryListing: [],
      ));
    }
  }
}
