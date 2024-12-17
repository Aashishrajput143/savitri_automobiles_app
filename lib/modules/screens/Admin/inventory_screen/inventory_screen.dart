import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/inventory_cubit/inventory_tab_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/inventory_screen/implements_inventory_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/inventory_screen/oil_inventory_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/inventory_screen/spareparts_inventory_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/inventory_screen/tractor_inventory_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InventoryTabCubit(),
      child: const InventoryPageView(),
    );
  }
}

class InventoryPageView extends StatelessWidget {
  const InventoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      initialtab: 0,
      tabs: 4,
      autoimplement: false,
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Inventory",
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
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        onTap: (index) {
          context.read<InventoryTabCubit>().changeTab(index);
        },
        tabs: const [
          SizedBox(width: 60, child: Tab(text: 'Tractor')),
          SizedBox(width: 80, child: Tab(text: 'Implements')),
          SizedBox(width: 70, child: Tab(text: 'Spareparts')),
          SizedBox(width: 40, child: Tab(text: 'Oil')),
        ],
      ),
      body: BlocBuilder<InventoryTabCubit, int>(
        builder: (context, state) {
          return const TabBarView(
            children: [
              TractorInventoryScreen(),
              ImplementsInventoryScreen(),
              SparePartsInventoryScreen(),
              OilInventoryScreen(),
            ],
          );
        },
      ),
      currentIndex: 2,
      onBottomNavTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, Routes.registration);
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, Routes.executive);
        }
      },
    );
  }
}
