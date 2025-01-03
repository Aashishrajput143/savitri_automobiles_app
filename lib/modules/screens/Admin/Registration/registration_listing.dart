import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/registration_cubit/registration_tab_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Registration/service_listing.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Registration/tractor_listing.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class RegistrationListingScreen extends StatelessWidget {
  const RegistrationListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationTabCubit(),
      child: const RegistrationPageView(),
    );
  }
}

class RegistrationPageView extends StatelessWidget {
  const RegistrationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final initialtab = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    print('Received arguments: $initialtab');
    return CommonScreen(
      initialtab: initialtab,
      tabs: 2,
      autoimplement: false,
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Registrations",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centertitle: true,
      appBarActions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.search);
          },
          icon: const Icon(Icons.search),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.notification);
          },
          icon: const Icon(Icons.notifications_outlined),
          color: Colors.black,
        ),
      ],
      bottomtabs: TabBar(
        onTap: (index) {
          context.read<RegistrationTabCubit>().changeTab(index);
        },
        tabs: const [
          Tab(text: 'Tractor & Implements'),
          Tab(text: 'Services'),
        ],
      ),
      body: BlocBuilder<RegistrationTabCubit, int>(
        builder: (context, state) {
          return const TabBarView(
            children: [
              TractorListingScreen(),
              ServiceListingScreen(),
            ],
          );
        },
      ),
      currentIndex: 1,
    );
  }
}
