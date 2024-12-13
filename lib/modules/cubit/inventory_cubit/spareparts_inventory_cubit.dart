import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class SparePartsInventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  SparePartsInventoryState({required this.featuredProducts});

  SparePartsInventoryState copyWith({
    List<Map<String, dynamic>>? featuredProducts,
  }) {
    return SparePartsInventoryState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
    );
  }
}

class SparePartsInventoryCubit extends Cubit<SparePartsInventoryState> {
  SparePartsInventoryCubit()
      : super(
          SparePartsInventoryState(
            featuredProducts: [
              {
                "name": "Fuel Filter",
                "price": "3,000",
                "image": AppImages.fuelfilter,
                "stock": 5,
              },
              {
                "name": "Gear Box",
                "price": "7,000",
                "image": AppImages.gearbox,
                "stock": 7,
              },
              {
                "name": "ElectricoMagnetic Clutch",
                "price": "20,590",
                "image": AppImages.electronicclutch,
                "stock": 4,
              },
              {
                "name": "Volvo",
                "price": "4,000",
                "image": AppImages.volvo,
                "stock": 8,
              },
              {
                "name": "Pillow Block",
                "price": "9,000",
                "image": AppImages.pillowblock,
                "stock": 8,
              },
            ],
          ),
        );

  var priceController = TextEditingController();
  var stockController = TextEditingController();

  void updateProduct(int index, String? price, int? stock) {
    if (index != -1) {
      final updatedProduct = {
        ...state.featuredProducts[index],
        if (price != null) "price": price,
        if (stock != null) "stock": stock,
      };

      final updatedProducts =
          List<Map<String, dynamic>>.from(state.featuredProducts)
            ..[index] = updatedProduct;

      emit(state.copyWith(featuredProducts: updatedProducts));
    }
  }
}
