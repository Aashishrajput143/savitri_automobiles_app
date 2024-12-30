import 'package:savitri_automobiles_admin/modules/model/addserviceentrymodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getoilmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/getsparepartsmodel.dart';
import 'package:savitri_automobiles_admin/modules/model/gettractormodel.dart';

class AddServiceState {
  final GetTractorModel? gettractormodel;
  final GetSparePartsModel? spareparts;
  final AddServiceEntryModel? addServiceEntryModel;
  final List<Map<String, String>>? selectedspareparts;
  final List<Map<String, dynamic>>? selectedsparepartsdetails;
  final List<Map<String, String>>? selectedoils;
  final List<Map<String, dynamic>>? selectedoilsdetails;
  final double? totalsparepartsprice;
  final double? totaloilprice;
  final GetOilModel? oilsnames;
  final Docstractor? selectedTractor;
  final String? selectedTractormodel;
  final String? selectedservicetype;
  final String? paymentmethod;
  final int? servicechargeamount;

  final bool isLoading;
  final bool isSuccess;
  final String message;

  AddServiceState({
    required this.gettractormodel,
    this.totaloilprice,
    this.addServiceEntryModel,
    required this.spareparts,
    required this.oilsnames,
    this.selectedservicetype,
    this.totalsparepartsprice,
    this.paymentmethod,
    this.servicechargeamount,
    this.selectedTractormodel,
    this.selectedspareparts,
    this.selectedsparepartsdetails,
    this.selectedTractor,
    this.selectedoils,
    this.selectedoilsdetails,
    this.isLoading = false,
    this.isSuccess = false,
    this.message = "",
  });

  AddServiceState copyWith({
    GetTractorModel? gettractormodel,
    AddServiceEntryModel? addServiceEntryModel,
    List<Map<String, String>>? tractors,
    double? totalsparepartsprice,
    List<Map<String, String>>? selectedspareparts,
    List<Map<String, dynamic>>? selectedsparepartsdetails,
    GetSparePartsModel? spareparts,
    String? paymentmethod,
    int? servicechargeamount,
    double? totaloilprice,
    GetOilModel? oilsnames,
    Docstractor? selectedTractor,
    String? selectedTractormodel,
    List<Map<String, String>>? selectedoils,
    List<Map<String, dynamic>>? selectedoilsdetails,
    String? selectedservicetype,
    bool? isLoading,
    bool? isSuccess,
    String? message,
  }) {
    return AddServiceState(
      gettractormodel: gettractormodel ?? this.gettractormodel,
      totaloilprice: totaloilprice ?? this.totaloilprice,
      totalsparepartsprice: totalsparepartsprice ?? this.totalsparepartsprice,
      addServiceEntryModel: addServiceEntryModel ?? this.addServiceEntryModel,
      oilsnames: oilsnames ?? this.oilsnames,
      servicechargeamount: servicechargeamount ?? this.servicechargeamount,
      selectedoils: selectedoils ?? this.selectedoils,
      selectedoilsdetails: selectedoilsdetails ?? this.selectedoilsdetails,
      paymentmethod: paymentmethod ?? this.paymentmethod,
      selectedsparepartsdetails:
          selectedsparepartsdetails ?? this.selectedsparepartsdetails,
      spareparts: spareparts ?? this.spareparts,
      selectedTractormodel: selectedTractormodel ?? this.selectedTractormodel,
      selectedspareparts: selectedspareparts ?? this.selectedspareparts,
      selectedTractor: selectedTractor ?? this.selectedTractor,
      selectedservicetype: selectedservicetype ?? this.selectedservicetype,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddServiceState &&
        other.gettractormodel == gettractormodel &&
        totalsparepartsprice == totalsparepartsprice &&
        other.totaloilprice == totaloilprice &&
        other.servicechargeamount == servicechargeamount &&
        other.selectedTractormodel == selectedTractormodel &&
        other.addServiceEntryModel == addServiceEntryModel &&
        other.selectedoilsdetails == selectedoilsdetails &&
        other.selectedTractor == selectedTractor &&
        other.selectedspareparts == selectedspareparts &&
        other.selectedsparepartsdetails == selectedsparepartsdetails &&
        other.paymentmethod == paymentmethod &&
        other.spareparts == spareparts &&
        other.oilsnames == oilsnames &&
        other.selectedoils == selectedoils &&
        other.selectedservicetype == selectedservicetype &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode {
    return gettractormodel.hashCode ^
        totalsparepartsprice.hashCode ^
        selectedTractor.hashCode ^
        selectedTractormodel.hashCode ^
        addServiceEntryModel.hashCode ^
        totaloilprice.hashCode ^
        servicechargeamount.hashCode ^
        paymentmethod.hashCode ^
        selectedoilsdetails.hashCode ^
        selectedspareparts.hashCode ^
        selectedoils.hashCode ^
        selectedsparepartsdetails.hashCode ^
        oilsnames.hashCode ^
        spareparts.hashCode ^
        selectedservicetype.hashCode ^
        isLoading.hashCode ^
        isSuccess.hashCode ^
        message.hashCode;
  }
}

class AddServiceSuccess extends AddServiceState {
  AddServiceSuccess(String message)
      : super(
          gettractormodel: null,
          spareparts: null,
          totaloilprice: 0.0,
          totalsparepartsprice: 0.0,
          servicechargeamount: 0,
          selectedspareparts: [],
          selectedsparepartsdetails: [],
          selectedoils: [],
          selectedoilsdetails: [],
          oilsnames: null,
          selectedservicetype: '',
          isSuccess: true,
          message: message,
        );
}

class AddServiceError extends AddServiceState {
  AddServiceError(String message)
      : super(
          gettractormodel: null,
          servicechargeamount: 0,
          totalsparepartsprice: 0.0,
          totaloilprice: 0.0,
          spareparts: null,
          selectedspareparts: [],
          selectedsparepartsdetails: [],
          oilsnames: null,
          selectedoilsdetails: [],
          selectedoils: [],
          selectedservicetype: '',
          isSuccess: false,
          message: message,
        );
}

class AddServiceLoading extends AddServiceState {
  AddServiceLoading()
      : super(
          spareparts: null,
          servicechargeamount: 0,
          totaloilprice: 0.0,
          totalsparepartsprice: 0.0,
          gettractormodel: null,
          selectedspareparts: [],
          selectedsparepartsdetails: [],
          selectedoils: [],
          selectedoilsdetails: [],
          oilsnames: null,
          selectedservicetype: '',
          isLoading: true,
          message: 'Loading...',
        );
}
