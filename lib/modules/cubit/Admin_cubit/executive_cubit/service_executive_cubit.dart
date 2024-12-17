import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class ServiceExecutiveState {
  final List<Map<String, dynamic>> serviceExecutive;

  ServiceExecutiveState({
    required this.serviceExecutive,
  });
}

class ServiceExecutiveCubit extends Cubit<ServiceExecutiveState> {
  ServiceExecutiveCubit()
      : super(ServiceExecutiveState(
          serviceExecutive: [
            {
              "name": "Rajendra Singh",
              "id": "#100052",
              "profile": AppImages.profile,
            },
            {
              "name": "Pawan Kumar",
              "id": "#100049",
              "profile": AppImages.profile,
            },
            {
              "name": "Nipendra Singh",
              "id": "#100045",
              "profile": AppImages.profile,
            },
          ],
        ));
}
