import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/collection_cubit/sell_all_collection_cubit/collection_tab_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/collectionExecutive/collection_due_screen%20copy.dart';
import 'package:savitri_automobiles_admin/modules/screens/collectionExecutive/collection_paid_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CollectionTabCubit(),
      child: const CollectionPageView(),
    );
  }
}

class CollectionPageView extends StatelessWidget {
  const CollectionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionTabCubit(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Collection Entries'),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            automaticallyImplyLeading: true,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bottom: TabBar(
              onTap: (index) {
                context.read<CollectionTabCubit>().changeTab(index);
              },
              tabs: const [
                Tab(text: "Paid Entries"),
                Tab(text: "Due Entries"),
              ],
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.search);
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.notification);
                  },
                  icon: const Icon(Icons.notifications_outlined),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: BlocBuilder<CollectionTabCubit, int>(
            builder: (context, state) {
              return const TabBarView(
                children: [
                  CollectionPaidPage(),
                  CollectionDuePage(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
