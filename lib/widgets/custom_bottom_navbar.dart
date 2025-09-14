import 'package:flutter/material.dart';
import 'package:lubes_bazaar/config/app_colors.dart';
import 'package:lubes_bazaar/config/styles.dart'; // 👈 custom styles
import 'package:lubes_bazaar/screens/home/home.dart';
import 'package:lubes_bazaar/screens/mycart/mycart_page.dart';
import 'package:lubes_bazaar/screens/profile/profile_page.dart';
import 'package:lubes_bazaar/screens/search/search.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  void _navigateTo(int index, BuildContext context) {
    Widget page = const Homepage(); // Safe default

    switch (index) {
      case 0:
        page = const Homepage();
        break;
      case 1:
        // page = const HotOfferScreen();
        break;
      case 2:
        page = const MyCartPage();
        break;
      case 3:
        page = const SearchPage();
        break;
      case 4:
        page = const ProfilePage();
        break;
    }

    // Avoid re-navigating to the same page
    if (index != currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,

      /// ✅ Colors from AppColors
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.grey,

      /// ✅ Labels Style from AppTextStyles
      selectedLabelStyle: AppTextStyles.buttonText.copyWith(fontSize: 12),
      unselectedLabelStyle: AppTextStyles.body.copyWith(fontSize: 12),

      type: BottomNavigationBarType.fixed,
      onTap: (index) => _navigateTo(index, context),

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: "Hot Offer",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "My Cart",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
