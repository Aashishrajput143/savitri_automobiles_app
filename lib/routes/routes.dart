import 'package:flutter/material.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/collection_details_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/sales_executive_details_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/service_details_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Sales_Screen/sales_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/home_admin.dart';
import 'package:savitri_automobiles_admin/modules/screens/SalesExecutive/add_sales_entry_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/inventory_screen/inventory_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/SalesExecutive/review_sales_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/ServiceExecutive/add_service_entry_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/ServiceExecutive/preview_service_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/ServiceExecutive/service_entry_listing_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/ServiceExecutive/service_home_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/collectionExecutive/collection_home_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/collectionExecutive/collection_sales_screen/collection_sales_see_all_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/collectionExecutive/collection_service_screen/collection_service_see_all_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/login_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/notification_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Registration/registration_listing.dart';
import 'package:savitri_automobiles_admin/modules/screens/SalesExecutive/sales_entry_listing_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/SalesExecutive/sales_home_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/executive_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/search_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/tractor_details_screen.dart';

import '../modules/screens/SalesExecutive/preview_sales_screen.dart';
import '../modules/screens/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String search = '/search';
  static const String executive = '/executive';
  static const String tractordetails = '/tractordetails';
  static const String notification = '/notification';
  static const String registration = '/registration';
  static const String inventory = '/inventory';
  static const String saleHome = '/saleHome';
  static const String addSalesEntry = '/addSalesEntry';
  static const String reviewSalesEntry = '/reviewSalesEntry';
  static const String salesEntryListing = '/salesEntryListing';
  static const String salesscreen = '/salesscreen';
  static const String salespreview = '/salespreview';
  static const String servicereview = '/servicereview';
  static const String salesexecutivedetails = '/executivedetails';
  static const String serviceHome = '/serviceHome';
  static const String serviceEntrylisiting = '/serviceEntrylisiting';
  static const String addServiceEntry = '/addServiceEntry';
  static const String collectionHome = '/collection';
  static const String collectionSalesSeeAll = '/collectionSalesSeeAll';
  static const String collectionServiceSeeAll = '/collectionServiceSeeAll';
  static const String serviceexecutivedetails = '/serviceexecutivedetails';
  static const String collectionexecutivedetails =
      '/collectionexecutivedetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeAdminScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
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
      case serviceHome:
        return MaterialPageRoute(builder: (_) => const ServiceHomeScreen());
      case serviceEntrylisiting:
        return MaterialPageRoute(builder: (_) => const ServiceEntryListing());
      case addServiceEntry:
        return MaterialPageRoute(builder: (_) => const ServiceEntryScreen());
      case servicereview:
        return MaterialPageRoute(
            builder: (_) => const PreviewServiceScreen(), settings: settings);
      case salesscreen:
        return MaterialPageRoute(
            builder: (_) => const SalesScreen(), settings: settings);
      case salesexecutivedetails:
        return MaterialPageRoute(
            builder: (_) => const SalesExecutiveDetailsScreen(),
            settings: settings);
      case serviceexecutivedetails:
        return MaterialPageRoute(
            builder: (_) => const ServiceExecutiveDetailsScreen(),
            settings: settings);
      case collectionexecutivedetails:
        return MaterialPageRoute(
            builder: (_) => const CollectionExecutiveDetailsScreen(),
            settings: settings);
      case reviewSalesEntry:
        return MaterialPageRoute(
            builder: (_) => const ReviewSalesScreen(), settings: settings);
      case salespreview:
        return MaterialPageRoute(
            builder: (_) => const PreviewSalesScreen(), settings: settings);
      case registration:
        return MaterialPageRoute(
            builder: (_) => const RegistrationListingScreen());
      case executive:
        return MaterialPageRoute(builder: (_) => const ExecutiveScreen());
      case collectionHome:
        return MaterialPageRoute(builder: (_) => const CollectionHomeScreen());

      case collectionSalesSeeAll:
        return MaterialPageRoute(builder: (_) => const CollectionScreen());
      case collectionServiceSeeAll:
        return MaterialPageRoute(
            builder: (_) => const CollectionServiceScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
