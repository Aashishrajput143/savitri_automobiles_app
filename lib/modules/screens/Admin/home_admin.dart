import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/home_cubit/home_cubit.dart';
import 'package:savitri_automobiles_admin/modules/cubit/Admin_cubit/home_cubit/home_state.dart';
import 'package:savitri_automobiles_admin/modules/screens/common_screen.dart';
import 'package:savitri_automobiles_admin/resources/formatter.dart';
import 'package:savitri_automobiles_admin/resources/images.dart';
import 'package:savitri_automobiles_admin/routes/routes.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressTime;
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is HomeLogout) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sucessfully Logout")),
        );
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    }, builder: (context, state) {
      final cubit = context.read<HomeCubit>();
      return WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();
          if (lastBackPressTime == null ||
              now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
            lastBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Press back again to exit"),
                duration: Duration(seconds: 1),
              ),
            );
            return false; // Prevent exit
          }
          return true; // Exit the app
        },
        child: CommonScreen(
          initialtab: 0,
          bottomtabs: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: SizedBox.shrink(),
          ),
          tabs: 1,
          centertitle: false,
          autoimplement: false,
          appBarTitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: SizedBox(
              width: 50,
              height: 30,
              child: Image.asset(
                AppImages.logodash,
                fit: BoxFit.fill,
              ),
            ),
          ),
          appBarActions: [
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
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: PopupMenuButton<String>(
                color: Colors.white,
                offset: const Offset(0, 50),
                menuPadding: const EdgeInsets.symmetric(vertical: 3),
                onSelected: (value) {
                  if (value == 'logout') {
                    // Handle logout logic here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              cubit.logoutApi(context);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: CircleAvatar(
                  backgroundImage: AssetImage(AppImages.profile),
                  radius: 15,
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Logout"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              //final cubit = context.read<HomeCubit>();
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Analytics",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.salesscreen);
                            },
                            child: const Text("See all"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.salesscreen);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                        backgroundColor:
                                            Colors.green.withOpacity(0.2),
                                        child: const Icon(Icons.bar_chart,
                                            color: Colors.green, size: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Tractor Sales",
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
                                      "₹ 15 Lakh",
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
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.executive);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.2),
                                        child: const Icon(Icons.person,
                                            color: Colors.blue, size: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Total SalesMan",
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
                                      "6",
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
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.registration);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                        backgroundColor:
                                            Colors.purple.withOpacity(0.2),
                                        child: const Icon(
                                            Icons.app_registration,
                                            color: Colors.purple,
                                            size: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Sales Entries",
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
                                    padding:
                                        const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                                    child: Text(
                                      "${state.getSalesEntries?.data?.docs?.length}",
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
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.salesscreen,
                                  arguments: 1);
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
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
                                        backgroundColor:
                                            Colors.orange.withOpacity(0.2),
                                        child: const Icon(
                                            Icons.oil_barrel_outlined,
                                            color: Colors.orange,
                                            size: 16),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Services Sales",
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
                                      "₹ 78 K",
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       "Recent Sales Entries",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.pushNamed(context, Routes.registration);
                      //       },
                      //       child: const Text("See all"),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount:
                      //       (state.getSalesEntries?.data?.docs?.length ?? 0) > 5
                      //           ? 5
                      //           : state.getSalesEntries?.data?.docs?.length,
                      //   itemBuilder: (context, index) {
                      //     final entries =
                      //         state.getSalesEntries?.data?.docs?[index];
                      //     return InkWell(
                      //       onTap: () {
                      //         Navigator.pushNamed(
                      //           context,
                      //           Routes.salespreview,
                      //           arguments: entries?.sId ?? "",
                      //         );
                      //       },
                      //       child: Card(
                      //         color: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         margin: const EdgeInsets.symmetric(
                      //             vertical: 10.0, horizontal: 2),
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             ClipRRect(
                      //               borderRadius: BorderRadius.circular(8.0),
                      //               child: Image.asset(
                      //                 AppImages.swaraj735XT,
                      //                 width: 80,
                      //                 height: 80,
                      //                 fit: BoxFit.contain,
                      //                 errorBuilder:
                      //                     (context, error, stackTrace) {
                      //                   return const SizedBox(
                      //                     width: 80,
                      //                     height: 80,
                      //                     child: Center(
                      //                       child: Text(
                      //                         "No Image",
                      //                         style: TextStyle(fontSize: 11),
                      //                         textAlign: TextAlign.center,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //             const SizedBox(width: 10),
                      //             Expanded(
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(10.0),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     SizedBox(
                      //                       width: MediaQuery.of(context)
                      //                               .size
                      //                               .width *
                      //                           0.4,
                      //                       child: Text(
                      //                         entries?.tractor?.modelName ??
                      //                             "Not Available",
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 14,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       "₹${PriceFormatter.formatPrice(entries?.totalAmount ?? 0)} ",
                      //                       style: const TextStyle(
                      //                         fontSize: 14,
                      //                         color: Colors.green,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       "Salesman : ${entries?.customerName ?? "Not Available"}",
                      //                       style: const TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       cubit.getdate(
                      //                           entries?.createdAt ?? "", true),
                      //                       style: const TextStyle(
                      //                           fontSize: 11,
                      //                           fontWeight: FontWeight.bold,
                      //                           color: Color.fromARGB(
                      //                               255, 138, 137, 137)),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             const Padding(
                      //               padding: EdgeInsets.only(right: 15),
                      //               child: Center(
                      //                 heightFactor: 5.5,
                      //                 child: Text(
                      //                   "View Details",
                      //                   style: TextStyle(
                      //                       fontSize: 12,
                      //                       color: Color.fromARGB(
                      //                           255, 119, 33, 135),
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       "Recent Service Entries",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.pushNamed(context, Routes.registration,
                      //             arguments: 1);
                      //       },
                      //       child: const Text("See all"),
                      //     ),
                      //   ],
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount:
                      //       (state.getServiceEntries?.data?.docs?.length ?? 0) >
                      //               5
                      //           ? 5
                      //           : state.getServiceEntries?.data?.docs?.length,
                      //   itemBuilder: (context, index) {
                      //     final entries =
                      //         state.getServiceEntries?.data?.docs?[index];
                      //     return InkWell(
                      //       onTap: () {
                      //         Navigator.pushNamed(
                      //           context,
                      //           Routes.servicereview,
                      //           arguments: entries?.sId ?? "",
                      //         );
                      //       },
                      //       child: Card(
                      //         color: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         margin: const EdgeInsets.symmetric(
                      //             vertical: 10.0, horizontal: 2),
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             ClipRRect(
                      //               borderRadius: BorderRadius.circular(8.0),
                      //               child: Image.asset(
                      //                 AppImages.swaraj735XT,
                      //                 width: 80,
                      //                 height: 80,
                      //                 fit: BoxFit.contain,
                      //                 errorBuilder:
                      //                     (context, error, stackTrace) {
                      //                   return const SizedBox(
                      //                     width: 80,
                      //                     height: 80,
                      //                     child: Center(
                      //                       child: Text(
                      //                         "No Image",
                      //                         style: TextStyle(fontSize: 11),
                      //                         textAlign: TextAlign.center,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ),
                      //             const SizedBox(width: 10),
                      //             Expanded(
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(10.0),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     SizedBox(
                      //                       width: MediaQuery.of(context)
                      //                               .size
                      //                               .width *
                      //                           0.4,
                      //                       child: Text(
                      //                         entries?.tractor?.modelName ??
                      //                             "Not Available",
                      //                         style: const TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 14,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       "₹${PriceFormatter.formatPrice(entries?.totalCost ?? 0)} ",
                      //                       style: const TextStyle(
                      //                         fontSize: 14,
                      //                         color: Colors.green,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       "Serviceman : ${entries?.customerName ?? "Not Available"}",
                      //                       style: const TextStyle(
                      //                         fontSize: 12,
                      //                         fontWeight: FontWeight.bold,
                      //                       ),
                      //                     ),
                      //                     const SizedBox(height: 5),
                      //                     Text(
                      //                       cubit.getdate(
                      //                           entries?.createdAt ?? "", true),
                      //                       style: const TextStyle(
                      //                           fontSize: 11,
                      //                           fontWeight: FontWeight.bold,
                      //                           color: Color.fromARGB(
                      //                               255, 138, 137, 137)),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //             const Padding(
                      //               padding: EdgeInsets.only(right: 15),
                      //               child: Center(
                      //                 heightFactor: 5.5,
                      //                 child: Text(
                      //                   "View Details",
                      //                   style: TextStyle(
                      //                       fontSize: 12,
                      //                       color: Color.fromARGB(
                      //                           255, 119, 33, 135),
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // const SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       "Sales Executive",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.pushNamed(context, Routes.executive);
                      //       },
                      //       child: const Text("See all"),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 8),
                      //   child: ListView.separated(
                      //       shrinkWrap: true,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       itemCount: state.salesperson?.length ?? 0,
                      //       separatorBuilder: (context, index) =>
                      //           const Divider(),
                      //       itemBuilder: (context, index) {
                      //         final product = state.salesperson![index];
                      //         return InkWell(
                      //           child: ListTile(
                      //             onTap: () => Navigator.pushNamed(
                      //                 context, Routes.executivedetails),
                      //             leading: CircleAvatar(
                      //               backgroundImage:
                      //                   AssetImage("${product['profile']}"),
                      //             ),
                      //             title: Text(
                      //               "${product['name']}",
                      //               style: const TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 16,
                      //               ),
                      //             ),
                      //             subtitle: Text(
                      //               "Salesman-id ${product['id']}",
                      //               style: const TextStyle(
                      //                 color: Colors.grey,
                      //                 fontSize: 14,
                      //               ),
                      //             ),
                      //             trailing: const Icon(Icons.arrow_forward_ios),
                      //           ),
                      //         );
                      //       }),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
          currentIndex: 0,
        ),
      );
    });
  }
}
