import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/executive_cubit/executive_tab_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/collection_executive_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/sales_executive_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Executive/service_executive_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class ExecutiveScreen extends StatelessWidget {
  const ExecutiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExecutiveTabCubit(),
      child: const ExecutivePageView(),
    );
  }
}

class ExecutivePageView extends StatelessWidget {
  const ExecutivePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      initialtab: 0,
      tabs: 3,
      autoimplement: false,
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Executives",
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
          context.read<ExecutiveTabCubit>().changeTab(index);
        },
        tabs: const [
          Tab(text: 'Sales'),
          Tab(text: 'Service'),
          Tab(text: 'Collection'),
        ],
      ),
      body: BlocBuilder<ExecutiveTabCubit, int>(
        builder: (context, state) {
          return const TabBarView(
            children: [
              SalesExecutiveScreen(),
              ServiceExecutiveScreen(),
              CollectionExecutiveScreen(),
            ],
          );
        },
      ),
      currentIndex: 3,
      onBottomNavTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, Routes.registration);
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, Routes.inventory);
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, Routes.executive);
        }
      },
    );
  }
}
