import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/sales_person_cubit/sales_person_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/sales_person_cubit/sales_perspn_state.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
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
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Sales Persons Profile",
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
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Add Sales Person',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Sales Persons Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(8, (index) {
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(AppImages
                                  .profile), // Replace with your assets
                            ),
                            title: Text(
                              'April Curtis. ${index + 1}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Sales Person'),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                            )),
                      );
                    }),
                    const SizedBox(height: 16),

                    // Options Section
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildOptionRow(
                              title: 'Wallet',
                              trailing: Text(
                                'TZN 892K',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(),
                            _buildOptionRow(
                              title: 'Manage catalog',
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                            const Divider(),
                            _buildOptionRow(
                              title: 'Share catalog',
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                            const Divider(),
                            _buildOptionRow(
                              title: 'Push Notifications',
                              trailing: Switch(
                                value: true,
                                onChanged: (value) {},
                              ),
                            ),
                            const Divider(),
                            _buildOptionRow(
                              title: 'Set up 2 Factor Authentication',
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      currentIndex: 2,
      onBottomNavTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, Routes.tractorlisting);
        } else if (index == 2) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (index == 3) {
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      },
    );
  }

  Widget _buildOptionRow({required String title, required Widget trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing,
        ],
      ),
    );
  }
}
