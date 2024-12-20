import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class ExecutiveDetailsState {
  final List<Map<String, dynamic>> persondetails;
  final List<Map<String, dynamic>> register;

  ExecutiveDetailsState({required this.persondetails, required this.register});
}

class ExecutiveDetailsCubit extends Cubit<ExecutiveDetailsState> {
  ExecutiveDetailsCubit()
      : super(ExecutiveDetailsState(
          persondetails: [
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
          register: [
            {
              "name": "Swaraj 735FE",
              "price": "₹16,80,590",
              "image": AppImages.swaraj735FE,
              "owner": "Rajendra Singh",
              "date": "20 Oct 2024"
            },
            {
              "name": "Swaraj 735XT",
              "price": "₹36,00,000",
              "image": AppImages.swaraj735XT,
              "owner": "Pawan Kumar",
              "date": "15 Aug 2024"
            },
            {
              "name": "Swaraj 735FEePS",
              "price": "₹26,00,000",
              "image": AppImages.tractor735FEePS,
              "owner": "Nipendra Singh",
              "date": "25 Jul 2024"
            }
          ],
        ));
}
