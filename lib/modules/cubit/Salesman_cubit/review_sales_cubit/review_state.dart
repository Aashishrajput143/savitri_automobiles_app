import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';

abstract class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSuccess extends ReviewState {
  final GetSalesEntryDetailsModel getSalesDetailsByIDModel;

  ReviewSuccess({required this.getSalesDetailsByIDModel});
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError({required this.message});

  @override
  List<Object?> get props => [message];
}
