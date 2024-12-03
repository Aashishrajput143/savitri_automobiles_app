import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class TractorDetailsState {
  final List<Map<String, dynamic>> featuredProducts;

  TractorDetailsState({
    required this.featuredProducts,
  });
}

class TractorDetailsCubit extends Cubit<TractorDetailsState> {
  TractorDetailsCubit()
      : super(
          TractorDetailsState(
            featuredProducts: [
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
            ],
          ),
        );
}
