import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessSales extends LoginState {
  final String message;

  LoginSuccessSales({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginSuccessService extends LoginState {
  final String message;

  LoginSuccessService({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginSuccessAdmin extends LoginState {
  final String message;

  LoginSuccessAdmin({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginSuccessCollection extends LoginState {
  final String message;

  LoginSuccessCollection({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});

  @override
  List<Object?> get props => [message];
}
