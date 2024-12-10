import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class OilInventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  OilInventoryState({
    required this.featuredProducts,
  });
}

class OilInventoryCubit extends Cubit<OilInventoryState> {
  OilInventoryCubit()
      : super(
          OilInventoryState(
            featuredProducts: [
              {
                "name": "Cultivator",
                "price": "₹80,590",
                "image": AppImages.cultivator,
                "stock": 5,
              },
              {
                "name": "Plough",
                "price": "₹70,000",
                "image": AppImages.plough,
                "stock": 7,
              },
              {
                "name": "Rotary",
                "price": "₹1,80,590",
                "image": AppImages.rotary,
                "stock": 4,
              },
              {
                "name": "Harrow",
                "price": "₹90,000",
                "image": AppImages.harrow,
                "stock": 8,
              },
            ],
          ),
        );
}
