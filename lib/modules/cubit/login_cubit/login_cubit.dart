import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Example response handling
      if (email == 'admin123@gmail.com' && password == 'password123') {
        emit(LoginSuccessAdmin(message: 'Login Successful'));
      } else if (email == 'sales123@gmail.com' && password == 'password123') {
        emit(LoginSuccessSales(message: 'Login Successful'));
      } else if (email == 'service123@gmail.com' && password == 'password123') {
        emit(LoginSuccessService(message: 'Login Successful'));
      } else {
        emit(LoginError(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(LoginError(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
