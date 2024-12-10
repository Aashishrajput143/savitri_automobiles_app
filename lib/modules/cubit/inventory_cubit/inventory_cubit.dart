import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class InventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  InventoryState({
    required this.featuredProducts,
  });
}

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit()
      : super(
          InventoryState(
            featuredProducts: [
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "stock": 5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "stock": 7,
                "reviews": 122
              },
              {
                "name": "Swaraj 735FEePS",
                "price": "₹18,80,590",
                "image": AppImages.tractor735FEePS,
                "stock": 4,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT10",
                "price": "₹36,00,000",
                "image": AppImages.tractor,
                "stock": 8,
                "reviews": 122
              },
            ],
          ),
        );
}
