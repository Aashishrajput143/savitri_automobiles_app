import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CommonMethods {
  static String version = "";
  static Future<bool> checkInternetConnectivity() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
/*    final Connectivity _connectivity = Connectivity();

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
      if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.mobile) {
        print("===internetconnected==Mobile" + connectionStatus);
        isConnected = true;
        // I am connected to a mobile network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.wifi) {
        isConnected = true;
        print("===internetconnected==wifi" + connectionStatus);
        // I am connected to a wifi network.
      } else if (await _connectivity.checkConnectivity() ==
          ConnectivityResult.none) {
        isConnected = false;
        print("===internetconnected==not" + connectionStatus);
      }
    } on PlatformException catch (e) {
      print("===internet==not connected" + e.toString());
      connectionStatus = 'Failed to get connectivity.';
    }*/
    return isConnected;
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  static void moveCursorToastPos(TextEditingController textField) {
    var cursorPos =
        TextSelection.fromPosition(TextPosition(offset: textField.text.length));
    textField.selection = cursorPos;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast
          .LENGTH_SHORT, // You can also use Toast.LENGTH_LONG for a longer duration
      gravity: ToastGravity
          .BOTTOM, // You can choose other positions like TOP or CENTER
      timeInSecForIosWeb: 2, // Duration in iOS or web
      backgroundColor: Colors.black, // Background color of the toast
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Font size
    );
  }

  void showProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }

  void hideProgress(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
  }

  static void inputFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool isConnect = false;

  // static void showImageInPopUp(BuildContext context, String imageUrl) {
  //   showGeneralDialog(context: context,
  //       barrierDismissible: false,
  //       transitionDuration: const Duration(milliseconds: 100),
  //       transitionBuilder: (context, animation, secondaryAnimation, child) {
  //         return FadeTransition(
  //           opacity: animation,
  //           child: ScaleTransition(
  //             scale: animation,
  //             child: child,
  //           ),
  //         );
  //       },
  //       pageBuilder: (context, animation, secondaryAnimation){
  //         return  SafeArea(
  //           child: Stack(
  //             children: [
  //               PhotoView(
  //                 imageProvider: NetworkImage(imageUrl),
  //                 minScale: 0.3,
  //                 maxScale: 50.0,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  //
  // }
}
