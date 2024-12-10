import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/sales_cubit/service_sales_cubit.dart';

class ServiceSalesScreen extends StatelessWidget {
  const ServiceSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceSalesCubit(),
      child: const ServiceSalesPageView(),
    );
  }
}

class ServiceSalesPageView extends StatelessWidget {
  const ServiceSalesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceSalesCubit, ServiceSalesState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Service Analytics",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.green.withOpacity(0.2),
                                child: const Icon(Icons.bar_chart,
                                    color: Colors.green, size: 16),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Sold Spare Parts",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Text(
                              "25",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 170,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.blue.withOpacity(0.2),
                                child: const Icon(Icons.person,
                                    color: Colors.blue, size: 16),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Sold OIL (litres)",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Text(
                              "5",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
