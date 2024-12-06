import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/tractor_cubit/tractor_cubit.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';
import 'common_screen.dart';

class TractorScreen extends StatelessWidget {
  const TractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TractorCubit(),
      child: const TractorPageView(),
    );
  }
}

class TractorPageView extends StatelessWidget {
  const TractorPageView({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return CommonScreen(
      autoimplement: false,
      appBarTitle: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          "Tractor Collection",
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
      body: BlocBuilder<TractorCubit, TractorState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
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
                      'Add Tractor',
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
                  "Tractor Showcase",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: h * 0.68,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: state.featuredProducts.length,
                    itemBuilder: (context, index) {
                      var product = state.featuredProducts[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.tractordetails);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  image: DecorationImage(
                                    image: AssetImage("${product['image']}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${product['name']}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${product['price']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.orange, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${product['rating']} (${product['reviews']})",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      currentIndex: 1,
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
}
