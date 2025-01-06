import 'package:savitri_automobiles_admin/modules/model/addsalesentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getimplementsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class AddSaleState {
  final GetTractorModel? gettractormodel;
  final int? paidamount;
  final int? tractorprice;
  final int? implementprice;
  final int? exchangeprice;
  final int? insuranceprice;
  final int? registrationprice;
  final int? transportationprice;
  final int? financeprice;
  final GetImplementModel? getimplementmodel;
  final AddSalesEntryModel? addSalesEntryModel;
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
  AddSaleState({
    this.paidamount,
    this.getimplementmodel,
    this.selectedEquipmentsname,
    this.selectedEquipmentsprice,
    this.paymentmethod,
    this.tractorprice,
    this.implementprice,
    this.exchangeprice,
    this.insuranceprice,
    this.registrationprice,
    this.transportationprice,
    this.financeprice,
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
    int? paidamount,
    int? tractorprice,
    int? implementprice,
    int? exchangeprice,
    int? insuranceprice,
    int? registrationprice,
    int? transportationprice,
    int? financeprice,
    GetImplementModel? getimplementmodel,
    AddSalesEntryModel? addSalesEntryModel,
    String? selectedTractormodel,
    List<String>? selectedEquipments,
    List<String>? selectedEquipmentsname,
    List<int>? selectedEquipmentsprice,
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
        selectedEquipmentsname.hashCode ^
        selectedEquipmentsprice.hashCode ^
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
          isLoading: false,
          message: message,
        );
}

class AddSaleLoading extends AddSaleState {
  AddSaleLoading()
      : super(
          paidamount: 0,
          tractorprice: 0,
          implementprice: 0,
          exchangeprice: 0,
          insuranceprice: 0,
          registrationprice: 0,
          transportationprice: 0,
          financeprice: 0,
          selectedEquipments: [],
          selectedEquipmentsname: [],
          selectedEquipmentsprice: [],
          isChecked: false,
          isLoading: true,
          message: 'Loading...',
        );
}

class AddSalesLoading extends AddSaleState {
  AddSalesLoading({
    gettractormodel,
    getimplementmodel,
    addSalesEntryModel,
    selectedTractor,
    selectedTractormodel,
    selectedEquipments,
    selectedEquipmentsname,
    selectedEquipmentsprice,
    isChecked = false,
    registrationType,
    paymentmethod,
    finance,
    isSuccess = false,
    message = 'Loading...',
  }) : super(
          gettractormodel: gettractormodel,
          getimplementmodel: getimplementmodel,
          addSalesEntryModel: addSalesEntryModel,
          selectedTractor: selectedTractor,
          selectedTractormodel: selectedTractormodel,
          selectedEquipments: selectedEquipments,
          selectedEquipmentsname: selectedEquipmentsname,
          selectedEquipmentsprice: selectedEquipmentsprice,
          isChecked: isChecked,
          registrationType: registrationType,
          paymentmethod: paymentmethod,
          finance: finance,
          isSuccess: isSuccess,
          message: message,
        );
}
