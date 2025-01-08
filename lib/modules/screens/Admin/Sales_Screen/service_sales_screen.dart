import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/sales_cubit/service_graph_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/sales_cubit/service_graph_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ServiceSalesScreen extends StatelessWidget {
  const ServiceSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceGraphCubit(),
      child: const ServiceSalesPageView(),
    );
  }
}

class ServiceSalesPageView extends StatelessWidget {
  const ServiceSalesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceGraphCubit, ServiceGraphState>(
      builder: (context, state) {
        if (state is ServiceGraphLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ServiceGraphError) {
          return Center(
            child: Text(
              state.message ?? "",
              style: TextStyle(fontSize: 16),
            ),
          );
        }
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Services Analytics",
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Text(
                              "${state.getservicecount?.data?.sparePartsCount ?? 0}",
                              style: const TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: Text(
                              "${state.getservicecount?.data?.oilCount ?? 0}",
                              style: const TextStyle(
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Services Graph ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 1,
                    ),
                    legend: const Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries>[
                      ColumnSeries<Map<String, dynamic>, String>(
                        name: 'Spare Parts',
                        dataSource: state.sparePartData,
                        xValueMapper: (Map<String, dynamic> data, _) =>
                            data['month'] as String,
                        yValueMapper: (Map<String, dynamic> data, _) =>
                            data['sales'] as num,
                        dataLabelMapper: (Map<String, dynamic> data, _) =>
                            data['sales'] > 0 ? data['sales'].toString() : null,
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 37, 153, 255),
                            Color.fromARGB(255, 74, 255, 216),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.outer,
                        ),
                      ),
                      ColumnSeries<Map<String, dynamic>, String>(
                        name: 'OIL',
                        dataSource: state.oilData,
                        xValueMapper: (Map<String, dynamic> data, _) =>
                            data['month'] as String,
                        yValueMapper: (Map<String, dynamic> data, _) =>
                            data['sales'] as num,
                        dataLabelMapper: (Map<String, dynamic> data, _) =>
                            data['sales'] > 0 ? data['sales'].toString() : null,
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 102, 102),
                            Color.fromARGB(255, 255, 204, 204),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.outer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
