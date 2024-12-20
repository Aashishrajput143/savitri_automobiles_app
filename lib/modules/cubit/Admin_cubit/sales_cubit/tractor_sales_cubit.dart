import 'package:flutter_bloc/flutter_bloc.dart';

class TractorSalesState {
  final List<Map<String, dynamic>> tractorData;
  final List<Map<String, dynamic>> accessoryData;

  TractorSalesState({required this.tractorData, required this.accessoryData});
}

class TractorSalesCubit extends Cubit<TractorSalesState> {
  TractorSalesCubit()
      : super(
          TractorSalesState(
            tractorData: [],
            accessoryData: [],
          ),
        );

  void loadChartData() {
    final tractorSales = [
      {'month': 'Jan', 'sales': 10},
      {'month': 'Feb', 'sales': 20},
      {'month': 'Mar', 'sales': 15},
      {'month': 'Apr', 'sales': 25},
    ];

    final accessorySales = [
      {'month': 'Jan', 'sales': 5},
      {'month': 'Feb', 'sales': 10},
      {'month': 'Mar', 'sales': 8},
      {'month': 'Apr', 'sales': 12},
    ];

    emit(TractorSalesState(
        tractorData: tractorSales, accessoryData: accessorySales));
  }
}
