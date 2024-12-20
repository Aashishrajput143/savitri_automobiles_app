import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class TractorInventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  TractorInventoryState({required this.featuredProducts});

  TractorInventoryState copyWith({
    List<Map<String, dynamic>>? featuredProducts,
  }) {
    return TractorInventoryState(
      featuredProducts: featuredProducts ?? this.featuredProducts,
    );
  }
}

class TractorInventoryCubit extends Cubit<TractorInventoryState> {
  TractorInventoryCubit()
      : super(
          TractorInventoryState(
            featuredProducts: [
              {
                "name": "Swaraj 735FE",
                "price": "16,80,590",
                "image": AppImages.swaraj735FE,
                "stock": 5,
              },
              {
                "name": "Swaraj 735XT",
                "price": "36,00,000",
                "image": AppImages.swaraj735XT,
                "stock": 7,
              },
              {
                "name": "Swaraj 735FEePS",
                "price": "18,80,590",
                "image": AppImages.tractor735FEePS,
                "stock": 4,
              },
              {
                "name": "Swaraj 735XT10",
                "price": "36,00,000",
                "image": AppImages.tractor,
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
