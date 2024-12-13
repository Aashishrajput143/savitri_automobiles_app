import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationTabCubit extends Cubit<int> {
  RegistrationTabCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
