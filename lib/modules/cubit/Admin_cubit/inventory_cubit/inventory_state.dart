import 'package:equatable/equatable.dart';

abstract class InventoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventorySuccess extends InventoryState {
  final String message;

  InventorySuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class InventoryError extends InventoryState {
  final String message;

  InventoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
