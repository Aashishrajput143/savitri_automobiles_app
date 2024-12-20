import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class HomeState {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> featuredProducts;
  final List<Map<String, dynamic>> salesperson;
  final List<Map<String, dynamic>> register;

  HomeState({
    required this.categories,
    required this.featuredProducts,
    required this.salesperson,
    required this.register,
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
                "price": 1680590,
                "image": AppImages.swaraj735FE,
                "rating": 4.5,
                "reviews": 256
              },
              {
                "name": "Swaraj 735XT",
                "price": 3600000,
                "image": AppImages.swaraj735XT,
                "rating": 4.8,
                "reviews": 122
              },
            ],
            register: [
              {
                "name": "Swaraj 735FE",
                "price": 1680590,
                "image": AppImages.swaraj735FE,
                "salesperson": "Rajendra Singh",
                "date": "20 Oct 2024"
              },
              {
                "name": "Swaraj 735XT",
                "price": 3600000,
                "image": AppImages.swaraj735XT,
                "salesperson": "Pawan Kumar",
                "date": "15 Aug 2024"
              },
              {
                "name": "Swaraj 735FEePS",
                "price": 2600000,
                "image": AppImages.tractor735FEePS,
                "salesperson": "Nipendra Singh",
                "date": "25 Jul 2024"
              }
            ],
            salesperson: [
              {
                "name": "Rajendra Singh",
                "id": "#100052",
                "profile": AppImages.profile,
              },
              {
                "name": "Pawan Kumar",
                "id": "#100049",
                "profile": AppImages.profile,
              },
              {
                "name": "Nipendra Singh",
                "id": "#100045",
                "profile": AppImages.profile,
              },
            ],
          ),
        );
}
