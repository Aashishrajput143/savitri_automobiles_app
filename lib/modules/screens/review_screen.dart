import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/review_cubit/review_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/review_cubit/review_state.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewCubit(),
      child: const ReviewPage(),
    );
  }
}

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sales Review Screen'),
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
        ),
        body: BlocProvider(
            create: (_) => ReviewCubit()..fetchSalesEntries(),
            child: BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                if (state is ReviewLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReviewSuccess) {
                  if (state.message.isEmpty) {
                    return const Center(child: Text("No tractors available."));
                  }
                }
                return Container(
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
                  margin: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const Text(
                            "Tractor Details",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Tractor Name", "John Deere 5050D"),
                        _buildDetailRow("Model", "5050D"),
                        _buildDetailRow("PTO HP", "42.9 HP"),
                        _buildDetailRow("Gear Box",
                            "8 Forward + 2 Reverse/12 Forward+ 3 Reverse"),
                        _buildDetailRow(
                            "Breaks", "Dry Disc / oil Immersed (Brake)"),
                        _buildDetailRow("Warranty", "6 years"),
                        _buildDetailRow("Clutch", "single/Dual"),
                        _buildDetailRow("Lifting Capacity", "2000 kg"),
                        _buildDetailRow("WheelDrive", "2 WD"),
                        _buildDetailRow("Engine Rated RPM", "2000"),
                        _buildDetailRow(
                            "Steering", "Mechanical/Power Steering"),
                        _buildDetailRow("Number", "JD12345"),
                        _buildDetailRow("Price", "500000"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(thickness: 1.5),
                        const Text(
                          "Customer Details",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Name", "Ananya Srivastava"),
                        _buildDetailRow(
                            "Email", "ananyasrivastava9827@gmail.com"),
                        _buildDetailRow("contact", "6387052463"),
                        _buildDetailRow("Address", "Noida"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(thickness: 1.5),
                        const Text(
                          "Registration Details",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Registration Type", "Commercial"),
                        _buildDetailRow("Registration Cost", "8976"),
                        _buildDetailRow(
                            "Registration number", "12345677788965"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(thickness: 1.5),
                        const Text(
                          "Insurance Details",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Insurance Provider", "Commercial"),
                        _buildDetailRow("Policy Number", "897678899"),
                        _buildDetailRow("Insurance Cost", "1259"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(thickness: 1.5),
                        const Text(
                          "Pricing  Details",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Payment Method", "Cash"),
                        _buildDetailRow("Paid Amount", "32,10,000"),
                        _buildDetailRow("Due Amount", "49,000"),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(thickness: 1.5),
                        const Text(
                          "Discount  Details",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(thickness: 1.5),
                        _buildDetailRow("Discount Type", "In Percent(%)"),
                        _buildDetailRow("Discount Value", "30"),
                      ],
                    ),
                  ),
                );
              },
            )));
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              overflow: TextOverflow.clip,
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
