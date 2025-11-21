// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Step 1: Navigation Controller - Manages which page is active
class NavigationController extends GetxController {
  var currentIndex = 0.obs; // Observable variable for current page index
  var isExpanded = true.obs; // Observable variable for sidebar expanded/collapsed

  void changePage(int index) {
    currentIndex.value = index;
  }

  void toggleSidebar() {
    isExpanded.value = !isExpanded.value;
  }
}

// Step 2: Main Navigation Page - Contains sidebar + content area
class MainNavigationPage extends StatelessWidget {
  MainNavigationPage({super.key});

  final NavigationController navController = Get.put(NavigationController());

  // List of all your pages
  final List<Widget> pages = [
    FirstScaffold(),
    SecoundScaffold(),
    ThirdScaffold(),
    FourthScaffold(),
    FifthScaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT SIDEBAR - Navigation Menu
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: navController.isExpanded.value ? 250 : 70,
              color: Color(0xFF1e293b),
              child: Column(
                children: [
                  // Header Section
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.dashboard, color: Colors.white, size: 28),
                        if (navController.isExpanded.value) ...[
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'My App',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Divider(color: Colors.white24, height: 1),

                  // Navigation Menu Items
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      children: [
                        _buildNavItem(icon: Icons.looks_one, label: 'First Page', index: 0),
                        _buildNavItem(icon: Icons.looks_two, label: 'Second Page', index: 1),
                        _buildNavItem(icon: Icons.looks_3, label: 'Third Page', index: 2),
                        _buildNavItem(icon: Icons.looks_4, label: 'Fourth Page', index: 3),
                        _buildNavItem(icon: Icons.looks_5, label: 'Fifth Page', index: 4),
                      ],
                    ),
                  ),

                  // Toggle Sidebar Button
                  Divider(color: Colors.white24, height: 1),
                  InkWell(
                    onTap: navController.toggleSidebar,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            navController.isExpanded.value
                                ? Icons.chevron_left
                                : Icons.chevron_right,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT SIDE - Main Content Area (Your Pages)
          Expanded(child: Obx(() => pages[navController.currentIndex.value])),
        ],
      ),
    );
  }

  // Helper method to build each navigation item
  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    return Obx(() {
      final isSelected = navController.currentIndex.value == index;
      final isExpanded = navController.isExpanded.value;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.blue, width: 1) : null,
        ),
        child: InkWell(
          onTap: () => navController.changePage(index),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: isSelected ? Colors.blue : Colors.white70, size: 24),
                if (isExpanded) ...[
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.white70,
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Step 3: Your Existing Scaffold Pages
class FirstScaffold extends StatelessWidget {
  const FirstScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(child: Text('First Screen', style: TextStyle(fontSize: 24))),
    );
  }
}

class SecoundScaffold extends StatelessWidget {
  const SecoundScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(child: Text('Second Screen', style: TextStyle(fontSize: 24))),
    );
  }
}

class ThirdScaffold extends StatelessWidget {
  const ThirdScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Third Page")),
      body: Center(child: Text('Third Screen', style: TextStyle(fontSize: 24))),
    );
  }
}

class FourthScaffold extends StatelessWidget {
  const FourthScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fourth Page")),
      body: Center(child: Text('Fourth Screen', style: TextStyle(fontSize: 24))),
    );
  }
}

class FifthScaffold extends StatelessWidget {
  const FifthScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fifth Page")),
      body: Center(child: Text('Fifth Screen', style: TextStyle(fontSize: 24))),
    );
  }
}

// Step 4: Main App Entry Point
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Must use GetMaterialApp (not MaterialApp)
      title: 'Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainNavigationPage(), // Set MainNavigationPage as home
    );
  }
}
