import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/service_home_cubit/service_home_states.dart';
import '../../../../resources/images.dart';

class ServiceHomeCubit extends Cubit<ServiceHomeStates> {
  final List<Map<String, dynamic>> recentlyAdded;
  final List<Map<String, dynamic>> topSellingTractor;

  ServiceHomeCubit()
      : recentlyAdded = [
          {
            "name": "Swaraj 735FE",
            "price": "₹16,80,590",
            "image": AppImages.swaraj735FE,
            "Buyer": "Rajendra Singh",
            "date": "20 Oct 2024"
          },
          {
            "name": "Swaraj 735XT",
            "price": "₹36,00,000",
            "image": AppImages.swaraj735XT,
            "Buyer": "Nipendra Singh",
            "date": "20 Oct 2024"
          },
          {
            "name": "Swaraj 735XT",
            "price": "₹36,00,000",
            "image": AppImages.swaraj735XT,
            "Buyer": "Shailendra Singh",
            "date": "20 Oct 2024"
          },
          {
            "name": "Swaraj 735XT",
            "price": "₹36,00,000",
            "image": AppImages.swaraj735XT,
            "Buyer": "Surendra Singh",
            "date": "20 Oct 2024"
          },
        ],
        topSellingTractor = [
          {
            "name": "Swaraj 735FE",
            "price": "₹26,80,590",
            "image": AppImages.swaraj735FE,
            "PTO": "24 HP",
            "RPM": 2800
          },
          {
            "name": "Swaraj 735XT",
            "price": "₹36,00,000",
            "image": AppImages.swaraj735XT,
            "PTO": "24 HP",
            "RPM": 2800
          },
          {
            "name": "Swaraj 735FEePS",
            "price": "₹18,00,000",
            "image": AppImages.tractor735FEePS,
            "PTO": "24 HP",
            "RPM": 2800
          },
          {
            "name": "Swaraj 735XT10",
            "price": "₹16,00,000",
            "image": AppImages.tractor,
            "PTO": "24 HP",
            "RPM": 2800
          },
        ],
        super(const ServiceHomeInitial());

  Future<void> addServiceEntry() async {
    emit(const ServiceHomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Simulate navigation trigger
      emit(const ServiceHomeSuccess(message: 'Navigate to next screen'));
    } catch (e) {
      emit(ServiceHomeError(message: 'An error occurred: ${e.toString()}'));
    }
  }

  List<Map<String, dynamic>> getRecentlyAdded() => recentlyAdded;

  List<Map<String, dynamic>> getTopSellingTractor() => topSellingTractor;
}
