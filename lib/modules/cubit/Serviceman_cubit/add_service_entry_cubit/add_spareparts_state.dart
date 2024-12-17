import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/add_service_entry_cubit/add_service_state.dart';

class AddSpareState {
  final List<String> spareparts;
  final List<Map<String, String>>? selectedspareparts;
  final SparePartsRepository? repository;

  AddSpareState({
    required this.spareparts,
    this.selectedspareparts,
    this.repository,
  });

  AddSpareState copyWith({
    List<Map<String, String>>? selectedspareparts,
    List<String>? spareparts,
  }) {
    return AddSpareState(
      spareparts: spareparts ?? this.spareparts,
      selectedspareparts: selectedspareparts ?? this.selectedspareparts,
    );
  }
}

class AddSpareSuccess extends AddSpareState {
  AddSpareSuccess(String message)
      : super(
          spareparts: [],
          selectedspareparts: [],
        );
}

class AddSpareError extends AddSpareState {
  AddSpareError(String message)
      : super(
          spareparts: [],
          selectedspareparts: [],
        );
}

class AddSpareLoading extends AddSpareState {
  AddSpareLoading()
      : super(
          spareparts: [],
          selectedspareparts: [],
        );
}
