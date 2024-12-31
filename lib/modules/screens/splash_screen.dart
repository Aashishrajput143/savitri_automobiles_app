import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/Constants/utils.dart';
import 'package:savitri_automobiles_admin/common/constants.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

import '../cubit/splash_cubit/splash_cubit.dart';
import '../cubit/splash_cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashCubit()..loadResources(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) async {
            if (state is SplashLoaded) {
              final token =
                  await Utils.getPreferenceValues(Constants.accessToken);
              Utils.printLog("token $token");

              if (token != "" && token != null) {
                final role = await Utils.getPreferenceValues(Constants.role);
                Utils.printLog("role $role");

                if (!context.mounted) return;

                if (role == "ADMINISTRATOR") {
                  Navigator.pushReplacementNamed(context, Routes.home);
                } else if (role == "SALES_EXECUTIVE") {
                  Navigator.pushReplacementNamed(context, Routes.saleHome);
                } else if (role == "SERVICE_EXECUTIVE") {
                  Navigator.pushReplacementNamed(context, Routes.serviceHome);
                } else if (role == "COLLECTION_EXECUTIVE") {
                  Navigator.pushReplacementNamed(
                      context, Routes.collectionHome);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.login);
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, Routes.login);
                }
              }
            }
          },
          child: Stack(
            children: [
              Image.asset(
                AppImages.splashscreen,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: 250,
                          height: 140,
                          child: Image.asset(
                            AppImages.logo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          'Empowering farmers with innovation, support, and progress.',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 40, top: 20),
                          child: Text(
                            '— Savitri Automobiles',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
