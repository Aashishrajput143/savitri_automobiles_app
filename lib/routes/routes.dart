import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/modules/screens/Sales_Screen/sales_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/add_sales_entry_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/inventory_screen/inventory_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/login_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/notification_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/registration_listing.dart';
import 'package:savitri_automobiles_admin/modules/screens/review_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/sales_entry_listing_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/sales_home_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/sales_person_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/search_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/tractor_details_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/tractor_screen.dart';

import '../modules/screens/home_screen.dart';
import '../modules/screens/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String search = '/search';
  static const String tractorlisting = '/tractorlisting';
  static const String salespersonsprofile = '/salespersonsprofile';
  static const String tractordetails = '/tractordetails';
  static const String notification = '/notification';
  static const String registration = '/registration';
  static const String inventory = '/inventory';
  static const String saleHome = '/saleHome';
  static const String addSalesEntry = '/addSalesEntry';
  static const String salesEntryListing = '/salesEntryListing';
  static const String salesscreen = '/salesscreen';
  static const String review = '/review';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case tractorlisting:
        return MaterialPageRoute(builder: (_) => const TractorScreen());
      case tractordetails:
        return MaterialPageRoute(builder: (_) => const TractorDetailsScreen());
      case notification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case inventory:
        return MaterialPageRoute(builder: (_) => const InventoryScreen());
      case addSalesEntry:
        return MaterialPageRoute(builder: (_) => const SalesEntryScreen());
      case salesEntryListing:
        return MaterialPageRoute(builder: (_) => const SalesEntryListing());
      case saleHome:
        return MaterialPageRoute(builder: (_) => const SalesHomeScreen());
      case salesscreen:
        return MaterialPageRoute(builder: (_) => const SalesScreen());
      case review:
        return MaterialPageRoute(builder: (_) => const ReviewScreen());
      case registration:
        return MaterialPageRoute(
            builder: (_) => const RegistrationListingScreen());
      case salespersonsprofile:
        return MaterialPageRoute(
            builder: (_) => const SalesPersonListingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
