import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Serviceman_cubit/review_service_cubit/review_state.dart';

class ReviewServiceCubit extends Cubit<ReviewServiceState> {
  ReviewServiceCubit() : super(ReviewServiceInitial());

  Future<void> fetchServiceEntries() async {
    try {
      emit(ReviewServiceLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(ReviewServiceSuccess(
        message: "Sales entries fetched successfully!",
      ));
    } catch (error) {
      emit(ReviewServiceError(
        message: "Failed to fetch sales entries.",
      ));
    }
  }
}
