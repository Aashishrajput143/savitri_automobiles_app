import 'package:equatable/equatable.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';

abstract class PreviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PreviewInitial extends PreviewState {}

class PreviewLoading extends PreviewState {}

class PreviewSuccess extends PreviewState {
  final GetSalesEntryDetailsModel getSalesDetailsByIDModel;

  PreviewSuccess({required this.getSalesDetailsByIDModel});
}

class PreviewError extends PreviewState {
  final String message;

  PreviewError({required this.message});

  @override
  List<Object?> get props => [message];
}
