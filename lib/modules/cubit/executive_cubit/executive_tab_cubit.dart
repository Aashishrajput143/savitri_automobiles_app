import 'package:flutter_bloc/flutter_bloc.dart';

class ExecutiveTabCubit extends Cubit<int> {
  ExecutiveTabCubit() : super(0);

  void changeTab(int index) {
    print("Tab Changed");
    emit(index);
  }
}
