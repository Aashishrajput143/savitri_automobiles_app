import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class TractorState {
  final List<Map<String, dynamic>> featuredProducts;

  TractorState({
    required this.featuredProducts,
  });
}

class TractorCubit extends Cubit<TractorState> {
  TractorCubit()
      : super(
          TractorState(
            featuredProducts: [
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "rating": 4.8,
                "reviews": 122
              },
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "rating": 4.8,
                "reviews": 122
              },
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "rating": 4.8,
                "reviews": 122
              },
            ],
          ),
        );
}
