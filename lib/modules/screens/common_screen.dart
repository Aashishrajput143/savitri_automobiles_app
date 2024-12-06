import 'package:flutter/material.dart';

class CommonScreen extends StatelessWidget {
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final Widget body;
  final int currentIndex;
  final Function(int) onBottomNavTap;
  final bool centertitle;

  const CommonScreen({
    super.key,
    required this.appBarTitle,
    required this.centertitle,
    required this.appBarActions,
    required this.body,
    required this.currentIndex,
    required this.onBottomNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: appBarTitle,
        centerTitle: centertitle,
        actions: appBarActions,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: "Registration",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Inventory",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
