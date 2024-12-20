import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savitri_automobiles_admin/modules/cubit/notification_cubit/notification_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationCubit(),
      child: const NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 16),
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.notification.length,
                    itemBuilder: (context, index) {
                      final notification = state.notification[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 25,
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset(notification['avatar']),
                          ),
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: notification['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' ${notification['action']}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          notification['message'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          notification['time'],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle "See all incoming activity"
                  },
                  child: const Text(
                    'See all incoming activity',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
