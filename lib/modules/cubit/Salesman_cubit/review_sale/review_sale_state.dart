import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class ReviewState {
  final GetTractorModel? gettractormodel;
  final GetImplementModel? getimplementmodel;
  final Docstractor? selectedTractor;
  final String? selectedTractormodel;
  final List<String>? selectedEquipments;
  final List<String>? selectedEquipmentsname;
  final List<int>? selectedEquipmentsprice;
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
  final int? totalprice;
  final int? paidamount;
  final int? tractorprice;
  final int? implementprice;
  final int? exchangeprice;
  final int? insuranceprice;
  final int? registrationprice;
  final int? transportationprice;
  final int? financeprice;
  ReviewState({
    this.getimplementmodel,
    this.paidamount,
    this.selectedEquipmentsname,
    this.selectedEquipmentsprice,
    this.paymentmethod,
    this.finance,
    this.tractorprice,
    this.implementprice,
    this.totalprice,
    this.exchangeprice,
    this.insuranceprice,
    this.registrationprice,
    this.transportationprice,
    this.financeprice,
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
    String? selectedTractormodel,
    List<String>? selectedEquipments,
    List<String>? selectedEquipmentsname,
    List<int>? selectedEquipmentsprice,
    int? paidamount,
    int? totalprice,
    int? tractorprice,
    int? implementprice,
    int? exchangeprice,
    int? insuranceprice,
    int? registrationprice,
    int? transportationprice,
    int? financeprice,
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
      totalprice: totalprice ?? this.totalprice,
      getimplementmodel: getimplementmodel ?? this.getimplementmodel,
      gettractormodel: gettractormodel ?? this.gettractormodel,
      selectedTractormodel: selectedTractormodel ?? this.selectedTractormodel,
      selectedEquipments: selectedEquipments ?? this.selectedEquipments,
      tractorprice: tractorprice ?? this.tractorprice,
      implementprice: implementprice ?? this.implementprice,
      exchangeprice: exchangeprice ?? this.exchangeprice,
      insuranceprice: insuranceprice ?? this.insuranceprice,
      registrationprice: registrationprice ?? this.registrationprice,
      selectedEquipmentsname:
          selectedEquipmentsname ?? this.selectedEquipmentsname,
      selectedEquipmentsprice:
          selectedEquipmentsprice ?? this.selectedEquipmentsprice,
      transportationprice: transportationprice ?? this.transportationprice,
      financeprice: financeprice ?? this.financeprice,
      paidamount: paidamount ?? this.paidamount,
      selectedTractor: selectedTractor ?? this.selectedTractor,
      isChecked: isChecked ?? this.isChecked,
      registrationType: registrationType ?? this.registrationType,
      paymentmethod: paymentmethod ?? this.paymentmethod,
      finance: finance ?? this.finance,
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
        other.totalprice == totalprice &&
        other.paidamount == paidamount &&
        other.tractorprice == tractorprice &&
        other.implementprice == implementprice &&
        other.exchangeprice == exchangeprice &&
        other.insuranceprice == insuranceprice &&
        other.registrationprice == registrationprice &&
        other.selectedEquipmentsname == selectedEquipmentsname &&
        other.selectedEquipmentsprice == selectedEquipmentsprice &&
        other.transportationprice == transportationprice &&
        other.financeprice == registrationprice &&
        other.getimplementmodel == getimplementmodel &&
        other.finance == finance &&
        other.paymentmethod == paymentmethod &&
        other.gettractormodel == gettractormodel &&
        other.selectedEquipments == selectedEquipments &&
        other.selectedEquipmentsname == selectedEquipmentsname &&
        other.selectedEquipmentsprice == selectedEquipmentsprice &&
        other.selectedTractor == selectedTractor &&
        other.registrationType == registrationType &&
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
        totalprice.hashCode ^
        gettractormodel.hashCode ^
        paidamount.hashCode ^
        tractorprice.hashCode ^
        implementprice.hashCode ^
        exchangeprice.hashCode ^
        insuranceprice.hashCode ^
        registrationprice.hashCode ^
        transportationprice.hashCode ^
        financeprice.hashCode ^
        selectedEquipments.hashCode ^
        finance.hashCode ^
        registrationType.hashCode ^
        paymentmethod.hashCode ^
        selectedTractor.hashCode ^
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
          paidamount: 0,
          totalprice: 0,
          tractorprice: 0,
          implementprice: 0,
          exchangeprice: 0,
          insuranceprice: 0,
          registrationprice: 0,
          transportationprice: 0,
          financeprice: 0,
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
          paidamount: 0,
          totalprice: 0,
          tractorprice: 0,
          implementprice: 0,
          exchangeprice: 0,
          insuranceprice: 0,
          registrationprice: 0,
          transportationprice: 0,
          financeprice: 0,
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
          isLoading: true,
          message: 'Loading...',
        );
}

class ReviewSaleLoading extends ReviewState {
  ReviewSaleLoading({
    GetTractorModel? gettractormodel,
    GetImplementModel? getimplementmodel,
    Docstractor? selectedTractor,
    String? selectedTractormodel,
    List<String>? selectedEquipments,
    List<String>? selectedEquipmentsname,
    List<int>? selectedEquipmentsprice,
    bool? isChecked = false,
    String? registrationType,
    String? paymentmethod,
    String? finance,
    bool? isLoading = true,
    bool? isSuccess = false,
    String? message = 'Loading...',
    bool? tractoreditcheck,
    bool? customereditcheck,
    bool? exhangeeditcheck,
    bool? registrationeditcheck,
    bool? equipmenteditcheck,
    bool? insuranceeditcheck,
    bool? financeeditcheck,
    bool? transportationeditcheck,
    bool? paymenteditcheck,
    int? totalprice,
    int? paidamount,
    int? tractorprice,
    int? implementprice,
    int? exchangeprice,
    int? insuranceprice,
    int? registrationprice,
    int? transportationprice,
    int? financeprice,
  }) : super(
          gettractormodel: gettractormodel,
          getimplementmodel: getimplementmodel,
          selectedTractor: selectedTractor,
          selectedTractormodel: selectedTractormodel,
          selectedEquipments: selectedEquipments,
          selectedEquipmentsname: selectedEquipmentsname,
          selectedEquipmentsprice: selectedEquipmentsprice,
          isChecked: isChecked,
          registrationType: registrationType,
          paymentmethod: paymentmethod,
          finance: finance,
          isLoading: isLoading,
          isSuccess: isSuccess,
          message: message,
          tractoreditcheck: tractoreditcheck,
          customereditcheck: customereditcheck,
          exhangeeditcheck: exhangeeditcheck,
          registrationeditcheck: registrationeditcheck,
          equipmenteditcheck: equipmenteditcheck,
          insuranceeditcheck: insuranceeditcheck,
          financeeditcheck: financeeditcheck,
          transportationeditcheck: transportationeditcheck,
          paymenteditcheck: paymenteditcheck,
          totalprice: totalprice,
          paidamount: paidamount,
          tractorprice: tractorprice,
          implementprice: implementprice,
          exchangeprice: exchangeprice,
          insuranceprice: insuranceprice,
          registrationprice: registrationprice,
          transportationprice: transportationprice,
          financeprice: financeprice,
        );
}
