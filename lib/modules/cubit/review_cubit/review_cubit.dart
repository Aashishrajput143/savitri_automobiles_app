import 'package:bloc/bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/review_cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  Future<void> fetchSalesEntries() async {
    try {
      emit(ReviewLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(ReviewSuccess(
        message: "Sales entries fetched successfully!",
      ));
    } catch (error) {
      emit(ReviewError(
        message: "Failed to fetch sales entries.",
      ));
    }
  }
}
