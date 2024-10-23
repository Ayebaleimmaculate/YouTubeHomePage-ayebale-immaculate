import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final List<String> notifications;

  const CustomAppBar({
    super.key,
    required this.userName,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/you.png',
                height: 30,
              ),
              const SizedBox(width: 8),
              const Text(
                'YouTube',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          ],
          backgroundColor: Colors.black,
        ),
        Container(
          color: Colors.black, // Same color as AppBar background
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 40, // Height for the category list
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryItem(label: 'All', onTap: () => _onCategoryTap('All')),
                CategoryItem(
                    label: 'Music', onTap: () => _onCategoryTap('Music')),
                CategoryItem(
                    label: 'Nollywood',
                    onTap: () => _onCategoryTap('Nollywood')),
                CategoryItem(
                    label: 'Mixes', onTap: () => _onCategoryTap('Mixes')),
                CategoryItem(
                    label: 'Sports', onTap: () => _onCategoryTap('Sports')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Handle category click
  void _onCategoryTap(String category) {
    // Example: Display a snackbar with the category clicked
    print("Category tapped: $category");
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(106.0); // Adjust height to fit categories
}

class CategoryItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap; // Callback for the tap action

  const CategoryItem({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap, // Make the category clickable
        child: Chip(
          label: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[800], // Category background color
        ),
      ),
    );
  }
}
