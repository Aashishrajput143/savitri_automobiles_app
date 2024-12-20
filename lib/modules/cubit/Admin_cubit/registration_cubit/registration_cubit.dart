import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class RegistrationState {
  final List<Map<String, dynamic>> register;

  RegistrationState({
    required this.register,
  });
}

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit()
      : super(
          RegistrationState(
            register: [
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "salesperson": "Rajendra Singh",
                "date": "20 Oct 2024"
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "salesperson": "Pawan Kumar",
                "date": "15 Aug 2024"
              },
              {
                "name": "Swaraj 735FEePS",
                "price": "₹26,00,000",
                "image": AppImages.tractor735FEePS,
                "salesperson": "Nipendra Singh",
                "date": "25 Jul 2024"
              }
            ],
          ),
        );
}
