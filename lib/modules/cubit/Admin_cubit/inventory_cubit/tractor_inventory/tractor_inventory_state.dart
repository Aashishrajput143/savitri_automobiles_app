import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class TractorInventoryState {
  final GetTractorModel? gettractormodel;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  TractorInventoryState({
    this.gettractormodel,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });
  TractorInventoryState copyWith({
    GetTractorModel? gettractormodel,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return TractorInventoryState(
      gettractormodel: gettractormodel ?? this.gettractormodel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TractorInventoryState &&
        other.gettractormodel == gettractormodel &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return gettractormodel.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class TractorInventorySuccess extends TractorInventoryState {
  TractorInventorySuccess(String message)
      : super(
          message: message,
        );
}

class TractorInventoryloaded extends TractorInventoryState {
  @override
  final GetTractorModel? gettractormodel;
  @override
  final String? message;
  TractorInventoryloaded({this.gettractormodel, this.message});
}

class TractorInventoryError extends TractorInventoryState {
  TractorInventoryError(String message)
      : super(
          isLoading: false,
          message: message,
        );
}

class TractorInventoryLoading extends TractorInventoryState {
  TractorInventoryLoading()
      : super(
          isLoading: true,
          message: 'Loading...',
        );
}
