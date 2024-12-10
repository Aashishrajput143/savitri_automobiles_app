import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/tractor_details_cubit/tractor_details_cubit.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';

class TractorDetailsScreen extends StatelessWidget {
  const TractorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TractorDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "Swaraj XT 6135E-135",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<TractorDetailsCubit, TractorDetailsState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Image.asset(
                    AppImages.swaraj735FE,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Swaraj XT 6135E-135 HP Tractor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tractors',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text('4.5', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Text('(256)', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Text(
                        '₹ 16,80,590',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock Available : ',
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 38.0),
                        child: Text(
                          '07 Stock',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 32, color: Colors.grey[300]),
                  const Text(
                    'Product Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The popular 75hp SEN is back and better than ever. Whether spraying, trimming, mowing, fruit handling, or transport—the SEN narrow frame glides easily through orchards and vineyards',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Divider(height: 32, color: Colors.grey[300]),
                  // Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Review (50)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  // Individual Review Item
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AppImages.swaraj735XT),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Moinur Rahman',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Today', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tractor exceeded my expectations with its powerful performance, robust build, and advanced features. The spacious cabin and intuitive controls make it a pleasure to drive, while its...',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  // Review Images
                  Row(
                    children: [
                      for (var i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            AppImages
                                .tractor735FEePS, // Replace with your image URL
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
