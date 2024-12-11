import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceSalesState {
  final List<Map<String, dynamic>> sparePartData;
  final List<Map<String, dynamic>> oilData;

  ServiceSalesState({required this.sparePartData, required this.oilData});
}

class ServiceSalesCubit extends Cubit<ServiceSalesState> {
  ServiceSalesCubit()
      : super(
          ServiceSalesState(
            sparePartData: [],
            oilData: [],
          ),
        );

  void loadChartData() {
    final sparepartsSales = [
      {'month': 'Jan', 'sales': 100},
      {'month': 'Feb', 'sales': 200},
      {'month': 'Mar', 'sales': 150},
      {'month': 'Apr', 'sales': 250},
    ];

    final oilSales = [
      {'month': 'Jan', 'sales': 50},
      {'month': 'Feb', 'sales': 100},
      {'month': 'Mar', 'sales': 80},
      {'month': 'Apr', 'sales': 120},
    ];

    emit(ServiceSalesState(sparePartData: sparepartsSales, oilData: oilSales));
  }
}
