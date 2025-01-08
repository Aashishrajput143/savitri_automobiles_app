import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionTabCubit extends Cubit<int> {
  CollectionTabCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
