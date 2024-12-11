import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockPriceFormCubit extends Cubit<Map<String, dynamic>> {
  StockPriceFormCubit() : super({"price": "", "stock": ""});

  final formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  void updatePrice(String price) {
    emit({...state, "price": price});
  }

  void updateStock(String stock) {
    emit({...state, "stock": stock});
  }

  void resetForm() {
    emit({"price": "", "stock": ""});
  }
}
