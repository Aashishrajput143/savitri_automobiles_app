import 'package:savitri_automobiles_admin/modules/model/addsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class AddSaleState {
  final GetTractorModel? gettractormodel;
  final GetImplementModel? getimplementmodel;
  final AddSalesEntryModel? addSalesEntryModel;
  final Docstractor? selectedTractor;
  final String? selectedTractormodel;
  final List<String>? selectedEquipments;
  final bool? isChecked;
  final String? registrationType;
  final String? paymentmethod;
  final String? finance;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  AddSaleState({
    this.getimplementmodel,
    this.paymentmethod,
    this.addSalesEntryModel,
    this.finance,
    this.gettractormodel,
    this.selectedTractormodel,
    this.selectedEquipments,
    this.selectedTractor,
    this.isChecked,
    this.registrationType,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });

  AddSaleState copyWith({
    GetTractorModel? gettractormodel,
    GetImplementModel? getimplementmodel,
    AddSalesEntryModel? addSalesEntryModel,
    String? selectedTractormodel,
    Map<String, String>? equipmentPrices,
    List<String>? selectedEquipments,
    Docstractor? selectedTractor,
    bool? isChecked,
    String? registrationType,
    String? paymentmethod,
    String? finance,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return AddSaleState(
      getimplementmodel: getimplementmodel ?? this.getimplementmodel,
      gettractormodel: gettractormodel ?? this.gettractormodel,
      selectedTractormodel: selectedTractormodel ?? this.selectedTractormodel,
      selectedEquipments: selectedEquipments ?? this.selectedEquipments,
      selectedTractor: selectedTractor ?? this.selectedTractor,
      isChecked: isChecked ?? this.isChecked,
      registrationType: registrationType ?? this.registrationType,
      paymentmethod: paymentmethod ?? this.paymentmethod,
      finance: finance ?? this.finance,
      addSalesEntryModel: addSalesEntryModel ?? this.addSalesEntryModel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddSaleState &&
        other.getimplementmodel == getimplementmodel &&
        other.finance == finance &&
        other.paymentmethod == paymentmethod &&
        other.gettractormodel == gettractormodel &&
        other.selectedEquipments == selectedEquipments &&
        other.selectedTractor == selectedTractor &&
        other.registrationType == registrationType &&
        other.addSalesEntryModel == addSalesEntryModel &&
        other.isChecked == isChecked &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return getimplementmodel.hashCode ^
        gettractormodel.hashCode ^
        selectedEquipments.hashCode ^
        finance.hashCode ^
        registrationType.hashCode ^
        paymentmethod.hashCode ^
        selectedTractor.hashCode ^
        addSalesEntryModel.hashCode ^
        isChecked.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class AddSaleSuccess extends AddSaleState {
  AddSaleSuccess(String message)
      : super(
          message: message,
        );
}

class AddSaleSuccessloading extends AddSaleState {
  AddSaleSuccessloading()
      : super(
          message: "Updated....",
        );
}

class AddSaleError extends AddSaleState {
  AddSaleError(String message)
      : super(
          isChecked: false,
          registrationType: "",
          paymentmethod: "",
          finance: "",
          isLoading: false,
          message: message,
        );
}

class AddSaleLoading extends AddSaleState {
  AddSaleLoading()
      : super(
          finance: "3 Months",
          paymentmethod: "CASH",
          isChecked: false,
          registrationType: "AGRICULTURE",
          isLoading: true,
          message: 'Loading...',
        );
}
