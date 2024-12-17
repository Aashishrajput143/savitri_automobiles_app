class AddSaleState {
  final List<Map<String, String>> tractors;
  final Map<String, String>? selectedTractor;
  final List<String> availableEquipments;
  final Map<String, String> equipmentPrices;
  final List<String> selectedEquipments;
  final bool isChecked;
  final String discountType;
  final String registrationType;
  final bool isLoading;
  final bool isSuccess;
  final String message;

  AddSaleState({
    required this.tractors,
    required this.availableEquipments,
    required this.equipmentPrices,
    required this.selectedEquipments,
    this.selectedTractor,
    required this.isChecked,
    required this.discountType,
    required this.registrationType,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });

  AddSaleState copyWith({
    List<Map<String, String>>? tractors,
    List<String>? availableEquipments,
    Map<String, String>? equipmentPrices,
    List<String>? selectedEquipments,
    Map<String, String>? selectedTractor,
    bool? isChecked,
    String? discountType,
    String? registrationType,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return AddSaleState(
      tractors: tractors ?? this.tractors,
      availableEquipments: availableEquipments ?? this.availableEquipments,
      equipmentPrices: equipmentPrices ?? this.equipmentPrices,
      selectedEquipments: selectedEquipments ?? this.selectedEquipments,
      selectedTractor: selectedTractor ?? this.selectedTractor,
      isChecked: isChecked ?? this.isChecked,
      discountType: discountType ?? this.discountType,
      registrationType: registrationType ?? this.registrationType,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddSaleState &&
        other.tractors == tractors &&
        other.availableEquipments == availableEquipments &&
        other.selectedTractor == selectedTractor &&
        other.isChecked == isChecked &&
        other.discountType == discountType &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return tractors.hashCode ^
        availableEquipments.hashCode ^
        selectedTractor.hashCode ^
        isChecked.hashCode ^
        discountType.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class AddSaleSuccess extends AddSaleState {
  AddSaleSuccess(String message)
      : super(
            tractors: [],
            isChecked: false,
            discountType: '',
            isSuccess: true,
            message: message,
            selectedEquipments: [],
            equipmentPrices: {},
            availableEquipments: [],
            registrationType: "");
}

class AddSaleError extends AddSaleState {
  AddSaleError(String message)
      : super(
          tractors: [],
          isChecked: false,
          discountType: '',
          registrationType: "",
          selectedEquipments: [],
          equipmentPrices: {},
          availableEquipments: [],
          isSuccess: false,
          message: message,
        );
}

class AddSaleLoading extends AddSaleState {
  AddSaleLoading()
      : super(
          tractors: [],
          isChecked: false,
          discountType: '',
          selectedEquipments: [],
          equipmentPrices: {},
          availableEquipments: [],
          registrationType: "",
          isLoading: true,
          message: 'Loading...',
        );
}
