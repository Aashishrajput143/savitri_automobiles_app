import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/sales_person_cubit/sales_perspn_state.dart';

class SalesPersonCubit extends Cubit<SalesPersonState> {
  SalesPersonCubit() : super(SalesPersonInitial());
}
