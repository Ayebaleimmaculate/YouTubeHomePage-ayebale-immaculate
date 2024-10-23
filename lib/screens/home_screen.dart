import 'package:flutter/material.dart';
import 'package:test_youtube/widgets/bottom_navigation_bar.dart'; // Import BottomNavBar
import 'package:test_youtube/widgets/app_bar.dart'; // Import your custom AppBar widget
import 'package:test_youtube/widgets/video_card.dart'; // Import VideoCard widget

// User model to represent the signed-in user
class User {
  final String name;
  final List<String> notifications;

  User({required this.name, required this.notifications});
}

class HomeScreen extends StatefulWidget {
  final User user; // Add a User field

  const HomeScreen({super.key, required this.user}); // Update constructor

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Function to handle navigation from the BottomNavBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF121212), // Dark background color
        appBarTheme: AppBarTheme(
          color: Color(0xFF1F1F1F), // Dark app bar
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F), // Dark bottom navigation bar
          //selectedItemColor: Colors.red, // YouTube red for selected items
          unselectedItemColor: Colors.grey, // Grey for unselected items
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Default text color
          bodyMedium: TextStyle(color: Colors.white70), // Secondary text color
        ),
      ),
      home: Scaffold(
        appBar: CustomAppBar(
          userName: widget.user.name,
          notifications: widget.user.notifications,
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavBar(
          onItemTapped: _onItemTapped, // Pass the tap function
          selectedIndex: _selectedIndex, // Pass the current index
        ),
      ),
    );
  }

  // Method to build the body based on the selected index
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0: // Home
        return Center(
          child: Text(
            'YouTube Home',
            style: const TextStyle(fontSize: 24),
          ),
        );
      case 1: // Videos
        return const VideoCard(); // Display VideoCard widget
      // Add more cases for other tabs if needed
      default:
        return Center(
          child: Text(
            'YouTube Home',
            style: const TextStyle(fontSize: 24),
          ),
        );
    }
  }
}
