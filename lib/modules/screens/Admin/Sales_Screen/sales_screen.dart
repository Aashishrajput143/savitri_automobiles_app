import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/sales_cubit/sales_tab_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Sales_Screen/service_sales_screen.dart';
import 'package:savitri_automobiles_admin/modules/screens/Admin/Sales_Screen/tractor_sales_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesTabCubit(),
      child: const SalesPageView(),
    );
  }
}

class SalesPageView extends StatelessWidget {
  const SalesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final initialtab = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    print('Received arguments: $initialtab');
    return DefaultTabController(
      initialIndex: initialtab,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "Sales Analytics",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          actions: [
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
          bottom: TabBar(
            onTap: (index) {
              context.read<SalesTabCubit>().changeTab(index);
            },
            tabs: const [
              Tab(text: 'Tractor & Implements'),
              Tab(text: 'Services'),
            ],
          ),
        ),
        body: BlocBuilder<SalesTabCubit, int>(
          builder: (context, state) {
            return const TabBarView(
              children: [
                TractorSalesScreen(),
                ServiceSalesScreen(),
              ],
            );
          },
        ),
      ),
    );
  }
}
