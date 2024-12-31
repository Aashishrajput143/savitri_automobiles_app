import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';

class ImplementInventoryState {
  final GetImplementModel? getImplementsmodel;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  ImplementInventoryState({
    this.getImplementsmodel,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });
  ImplementInventoryState copyWith({
    GetImplementModel? getImplementsmodel,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return ImplementInventoryState(
      getImplementsmodel: getImplementsmodel ?? this.getImplementsmodel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImplementInventoryState &&
        other.getImplementsmodel == getImplementsmodel &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getImplementsmodel.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class ImplementsInventorySuccess extends ImplementInventoryState {
  ImplementsInventorySuccess(String message)
      : super(
          message: message,
        );
}

class ImplementsInventoryloaded extends ImplementInventoryState {
  @override
  final GetImplementModel? getImplementsmodel;
  @override
  final String? message;
  ImplementsInventoryloaded({this.getImplementsmodel, this.message});
}

class ImplementsInventoryError extends ImplementInventoryState {
  ImplementsInventoryError(String message)
      : super(
          isLoading: false,
          message: message,
        );
}

class ImplementsInventoryLoading extends ImplementInventoryState {
  ImplementsInventoryLoading()
      : super(
          isLoading: true,
          message: 'Loading...',
        );
}
