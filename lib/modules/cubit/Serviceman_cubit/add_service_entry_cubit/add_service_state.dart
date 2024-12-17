class AddServiceState {
  final List<Map<String, String>> tractors;
  final List<String> spareparts;
  List<Map<String, String>>? selectedspareparts;
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

  AddServiceState({
    required this.tractors,
    required this.spareparts,
    this.selectedspareparts,
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

  AddServiceState copyWith({
    List<Map<String, String>>? tractors,
    List<Map<String, String>>? selectedspareparts,
    List<String>? spareparts,
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
    return AddServiceState(
      tractors: tractors ?? this.tractors,
      spareparts: spareparts ?? this.spareparts,
      selectedspareparts: selectedspareparts ?? this.selectedspareparts,
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
    return other is AddServiceState &&
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

class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess(String message)
      : super(
            tractors: [],
            spareparts: [],
            selectedspareparts: [],
            isChecked: false,
            discountType: '',
            isSuccess: true,
            message: message,
            selectedEquipments: [],
            equipmentPrices: {},
            availableEquipments: [],
            registrationType: "");
}

class AddServiceError extends AddServiceState {
  AddServiceError(String message)
      : super(
          tractors: [],
          spareparts: [],
          selectedspareparts: [],
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

class AddServiceLoading extends AddServiceState {
  AddServiceLoading()
      : super(
          tractors: [],
          spareparts: [],
          selectedspareparts: [],
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

class SparePartsRepository {
  List<Map<String, String>> selectedSpareParts = [];
}
