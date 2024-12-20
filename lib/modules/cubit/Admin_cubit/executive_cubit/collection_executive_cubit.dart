import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class CollectionExecutiveState {
  final List<Map<String, dynamic>> collectionExecutive;

  CollectionExecutiveState({
    required this.collectionExecutive,
  });
}

class CollectionExecutiveCubit extends Cubit<CollectionExecutiveState> {
  CollectionExecutiveCubit()
      : super(CollectionExecutiveState(
          collectionExecutive: [
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
          ],
        ));
}
