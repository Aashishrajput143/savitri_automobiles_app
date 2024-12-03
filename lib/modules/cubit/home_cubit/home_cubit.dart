import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class HomeState {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> featuredProducts;
  final List<Map<String, dynamic>> newArrivals;

  HomeState({
    required this.categories,
    required this.featuredProducts,
    required this.newArrivals,
  });
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            categories: [
              {"icon": Icons.car_rental, "label": "Tractors"},
              {"icon": Icons.agriculture, "label": "Harvesting"},
              {"icon": Icons.camera_alt_outlined, "label": "Agri Drones"},
              {"icon": Icons.construction, "label": "Preparation"},
              {"icon": Icons.grass, "label": "Planting"},
            ],
            featuredProducts: [
              {
                "name": "Swaraj 735FE",
                "price": "₹16,80,590",
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": "₹36,00,000",
                "image": AppImages.swaraj735XT,
                "rating": 4.8,
                "reviews": 122
              },
            ],
            newArrivals: [
              {
                "name": "Swaraj 735FEeps",
                "price": "₹1,50,000",
                "image": AppImages.tractor735FEePS,
                "rating": 4.7,
                "reviews": 312
              },
              {
                "name": "Swaraj 843 XM",
                "price": "₹2,75,000",
                "image": AppImages.tractor,
                "rating": 4.6,
                "reviews": 89
              },
            ],
          ),
        );
}
