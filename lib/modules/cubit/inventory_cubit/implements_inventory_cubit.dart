import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class ImplementsInventoryState {
  final List<Map<String, dynamic>> featuredProducts;

  ImplementsInventoryState({
    required this.featuredProducts,
  });
}

class ImplementsInventoryCubit extends Cubit<ImplementsInventoryState> {
  ImplementsInventoryCubit()
      : super(
          ImplementsInventoryState(
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
