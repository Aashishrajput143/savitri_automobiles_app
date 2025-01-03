import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsalesentrydetailsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class ReviewState {
  final GetTractorModel? gettractormodel;
  final GetImplementModel? getimplementmodel;
  final GetSalesEntryDetailsModel? getSalesEntryDetailsModel;
  final Docstractor? selectedTractor;
  final String? selectedTractormodel;
  final List<String>? selectedEquipments;
  final List<String>? selectedEquipmentsname;
  final List<String>? selectedEquipmentsprice;
  final bool? isChecked;
  final String? registrationType;
  final String? paymentmethod;
  final String? finance;
  final bool? isLoading;
  final bool? isSuccess;
  final String? message;
  final bool? tractoreditcheck;
  final bool? customereditcheck;
  final bool? exhangeeditcheck;
  final bool? registrationeditcheck;
  final bool? equipmenteditcheck;
  final bool? insuranceeditcheck;
  final bool? financeeditcheck;
  final bool? transportationeditcheck;
  final bool? paymenteditcheck;
  ReviewState({
    this.getimplementmodel,
    this.selectedEquipmentsname,
    this.selectedEquipmentsprice,
    this.paymentmethod,
    this.getSalesEntryDetailsModel,
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
    this.tractoreditcheck,
    this.customereditcheck,
    this.registrationeditcheck,
    this.exhangeeditcheck,
    this.equipmenteditcheck,
    this.insuranceeditcheck,
    this.financeeditcheck,
    this.transportationeditcheck,
    this.paymenteditcheck,
  });

  ReviewState copyWith({
    GetTractorModel? gettractormodel,
    GetImplementModel? getimplementmodel,
    GetSalesEntryDetailsModel? getSalesEntryDetailsModel,
    String? selectedTractormodel,
    List<String>? selectedEquipments,
    List<String>? selectedEquipmentsname,
    List<String>? selectedEquipmentsprice,
    Docstractor? selectedTractor,
    bool? isChecked,
    String? registrationType,
    String? paymentmethod,
    String? finance,
    bool? isLoading,
    bool? isSuccess,
    String? message,
    bool? tractoreditcheck,
    bool? customereditcheck,
    bool? registrationeditcheck,
    bool? exhangeeditcheck,
    bool? equipmenteditcheck,
    bool? insuranceeditcheck,
    bool? financeeditcheck,
    bool? transportationeditcheck,
    bool? paymenteditcheck,
  }) {
    return ReviewState(
      getimplementmodel: getimplementmodel ?? this.getimplementmodel,
      gettractormodel: gettractormodel ?? this.gettractormodel,
      selectedTractormodel: selectedTractormodel ?? this.selectedTractormodel,
      selectedEquipments: selectedEquipments ?? this.selectedEquipments,
      selectedEquipmentsname:
          selectedEquipmentsname ?? this.selectedEquipmentsname,
      selectedEquipmentsprice:
          selectedEquipmentsprice ?? this.selectedEquipmentsprice,
      selectedTractor: selectedTractor ?? this.selectedTractor,
      isChecked: isChecked ?? this.isChecked,
      registrationType: registrationType ?? this.registrationType,
      paymentmethod: paymentmethod ?? this.paymentmethod,
      finance: finance ?? this.finance,
      getSalesEntryDetailsModel:
          getSalesEntryDetailsModel ?? this.getSalesEntryDetailsModel,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      tractoreditcheck: tractoreditcheck ?? this.tractoreditcheck,
      customereditcheck: customereditcheck ?? this.customereditcheck,
      registrationeditcheck:
          registrationeditcheck ?? this.registrationeditcheck,
      exhangeeditcheck: exhangeeditcheck ?? this.exhangeeditcheck,
      equipmenteditcheck: equipmenteditcheck ?? this.equipmenteditcheck,
      insuranceeditcheck: insuranceeditcheck ?? this.insuranceeditcheck,
      financeeditcheck: financeeditcheck ?? this.financeeditcheck,
      transportationeditcheck:
          transportationeditcheck ?? this.transportationeditcheck,
      paymenteditcheck: paymenteditcheck ?? this.paymenteditcheck,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ReviewState &&
        other.getimplementmodel == getimplementmodel &&
        other.finance == finance &&
        other.paymentmethod == paymentmethod &&
        other.gettractormodel == gettractormodel &&
        other.selectedEquipments == selectedEquipments &&
        other.selectedEquipmentsname == selectedEquipmentsname &&
        other.selectedEquipmentsprice == selectedEquipmentsprice &&
        other.selectedTractor == selectedTractor &&
        other.registrationType == registrationType &&
        other.getSalesEntryDetailsModel == getSalesEntryDetailsModel &&
        other.isChecked == isChecked &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.tractoreditcheck == tractoreditcheck &&
        other.customereditcheck == customereditcheck &&
        other.registrationeditcheck == registrationeditcheck &&
        other.exhangeeditcheck == exhangeeditcheck &&
        other.equipmenteditcheck == equipmenteditcheck &&
        other.insuranceeditcheck == insuranceeditcheck &&
        other.financeeditcheck == financeeditcheck &&
        other.transportationeditcheck == transportationeditcheck &&
        other.paymenteditcheck == paymenteditcheck &&
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
        getSalesEntryDetailsModel.hashCode ^
        selectedEquipmentsname.hashCode ^
        selectedEquipmentsprice.hashCode ^
        isChecked.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        tractoreditcheck.hashCode ^
        customereditcheck.hashCode ^
        registrationeditcheck.hashCode ^
        exhangeeditcheck.hashCode ^
        equipmenteditcheck.hashCode ^
        insuranceeditcheck.hashCode ^
        financeeditcheck.hashCode ^
        transportationeditcheck.hashCode ^
        paymenteditcheck.hashCode ^
        message.hashCode;
  }
}

class ReviewSuccess extends ReviewState {
  ReviewSuccess(String message)
      : super(
          message: message,
        );
}

class ReviewError extends ReviewState {
  ReviewError(String message)
      : super(
          selectedEquipments: [],
          selectedEquipmentsname: [],
          selectedEquipmentsprice: [],
          selectedTractor: null,
          isChecked: false,
          tractoreditcheck: false,
          customereditcheck: false,
          registrationeditcheck: false,
          exhangeeditcheck: false,
          equipmenteditcheck: false,
          insuranceeditcheck: false,
          financeeditcheck: false,
          transportationeditcheck: false,
          paymenteditcheck: false,
          registrationType: "",
          paymentmethod: "",
          finance: "",
          isLoading: false,
          message: message,
        );
}

class ReviewLoading extends ReviewState {
  ReviewLoading()
      : super(
          selectedEquipments: [],
          selectedEquipmentsname: [],
          selectedEquipmentsprice: [],
          selectedTractor: null,
          finance: "3 Months",
          paymentmethod: "CASH",
          isChecked: false,
          tractoreditcheck: false,
          customereditcheck: false,
          registrationeditcheck: false,
          exhangeeditcheck: false,
          equipmenteditcheck: false,
          insuranceeditcheck: false,
          financeeditcheck: false,
          transportationeditcheck: false,
          paymenteditcheck: false,
          registrationType: "AGRICULTURE",
          isLoading: true,
          message: 'Loading...',
        );
}

class ReviewSaleLoading extends ReviewState {
  ReviewSaleLoading({
    gettractormodel,
    getimplementmodel,
    getSalesEntryDetailsModel,
    selectedTractor,
    selectedTractormodel,
    selectedEquipments,
    isChecked = false,
    registrationType,
    paymentmethod,
    finance,
    isSuccess = false,
    message = 'Loading...',
  }) : super(
          gettractormodel: gettractormodel,
          getimplementmodel: getimplementmodel,
          getSalesEntryDetailsModel: getSalesEntryDetailsModel,
          selectedTractor: selectedTractor,
          selectedTractormodel: selectedTractormodel,
          selectedEquipments: selectedEquipments,
          isChecked: isChecked,
          registrationType: registrationType,
          paymentmethod: paymentmethod,
          finance: finance ?? "3 Months",
          isSuccess: isSuccess,
          message: message,
        );
}
