import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class OilInventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  OilInventoryState({required this.featuredProducts});

  OilInventoryState copyWith({
    List<Map<String, dynamic>>? featuredProducts,
  }) {
    return OilInventoryState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
    );
  }
}

class OilInventoryCubit extends Cubit<OilInventoryState> {
  OilInventoryCubit()
      : super(
          OilInventoryState(
            featuredProducts: [
              {
                "name": "Swaraj Agri Motul",
                "price": "2,590",
                "image": AppImages.motul,
                "stock": 5,
              },
              {
                "name": "Swaraj magnetic Oil",
                "price": "7,000",
                "image": AppImages.magnetic,
                "stock": 7,
              },
              {
                "name": "Swaraj edge Oil",
                "price": "4,590",
                "image": AppImages.edge,
                "stock": 4,
              },
              {
                "name": "Swaraj GTX Mobil",
                "price": "5,000",
                "image": AppImages.gtx,
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
