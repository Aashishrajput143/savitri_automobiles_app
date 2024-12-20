import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/splash_cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> loadResources() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 4));
    emit(SplashLoaded());
  }
}
