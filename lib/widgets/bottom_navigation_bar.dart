import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onItemTapped; // Add this
  final int selectedIndex; // Add this

  const BottomNavBar({
    super.key,
    required this.onItemTapped, // Pass the function
    required this.selectedIndex, // Pass the selected index
  });

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<String> _urls = [
    'https://www.youtube.com/', // Home
    'https://www.youtube.com/feed/explore', // Shorts (Explore section)
    'https://www.youtube.com/upload', // Upload
    'https://www.youtube.com/feed/subscriptions', // Subscriptions
    'https://www.youtube.com/account', // You
  ];

  Future<void> _launchUrl(int index) async {
    final url = _urls[index];
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onItemTapped(int index) {
    _launchUrl(index); // Open URL
    widget.onItemTapped(index); // Notify HomeScreen of the tap
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex, // Use passed selectedIndex
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library),
          label: 'Shorts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'You',
        ),
      ],
    );
  }
}
