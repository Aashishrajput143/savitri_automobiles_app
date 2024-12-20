import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryTabCubit extends Cubit<int> {
  InventoryTabCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
