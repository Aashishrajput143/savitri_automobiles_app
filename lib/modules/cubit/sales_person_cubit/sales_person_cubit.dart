import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class SalesPersonState {
  final List<Map<String, dynamic>> salesperson;

  SalesPersonState({
    required this.salesperson,
  });
}

class SalesPersonCubit extends Cubit<SalesPersonState> {
  SalesPersonCubit()
      : super(SalesPersonState(
          salesperson: [
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
            {
              "name": "Shailendra Chauhan",
              "id": "#100052",
              "profile": AppImages.profile,
            },
            {
              "name": "Rajesh Kumar",
              "id": "#100049",
              "profile": AppImages.profile,
            },
            {
              "name": "Mohit Singh",
              "id": "#100045",
              "profile": AppImages.profile,
            },
          ],
        ));
}
