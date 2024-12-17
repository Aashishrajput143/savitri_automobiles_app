import 'package:flutter_bloc/flutter_bloc.dart';

class SalesTabCubit extends Cubit<int> {
  SalesTabCubit() : super(0);

  void changeTab(int index) {
    print("Tab Changed");
    emit(index);
  }
}
