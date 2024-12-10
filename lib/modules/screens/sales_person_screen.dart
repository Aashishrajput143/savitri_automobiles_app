import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/sales_person_cubit/sales_person_cubit.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class SalesPersonListingScreen extends StatelessWidget {
  const SalesPersonListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesPersonCubit(),
      child: const SalesPersonPageView(),
    );
  }
}

class SalesPersonPageView extends StatelessWidget {
  const SalesPersonPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      bottomtabs: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox.shrink(),
      ),
      tabs: 1,
      autoimplement: false,
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Sales Executives",
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
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
          color: Colors.black,
        ),
      ],
      body: BlocBuilder<SalesPersonCubit, SalesPersonState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Sales Executive Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.salesperson.length,
                    itemBuilder: (context, index) {
                      final product = state.salesperson[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage("${product['profile']}"),
                            ),
                            title: Text(
                              "${product['name']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "Salesman-id ${product['id']}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                          const Divider()
                        ],
                      );
                    }),
              ],
            ),
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
          Navigator.pushReplacementNamed(context, Routes.salespersonsprofile);
        }
      },
    );
  }
}
