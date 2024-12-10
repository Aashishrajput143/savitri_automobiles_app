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
                "name": "Swaraj Agri Motul",
                "price": "₹2,590",
                "image": AppImages.motul,
                "stock": 5,
              },
              {
                "name": "Swaraj magnetic Oil",
                "price": "₹7,000",
                "image": AppImages.magnetic,
                "stock": 7,
              },
              {
                "name": "Swaraj edge Oil",
                "price": "₹4,590",
                "image": AppImages.edge,
                "stock": 4,
              },
              {
                "name": "Swaraj GTX Mobil",
                "price": "₹5,000",
                "image": AppImages.gtx,
                "stock": 8,
              },
            ],
          ),
        );
}
