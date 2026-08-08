import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CartState.instance,
      builder: (context, _) {
        final count = CartState.instance.itemCount;

        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: "Orders",
            ),

            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: count > 0,
                label: Text("$count"),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
              activeIcon: Badge(
                isLabelVisible: count > 0,
                label: Text("$count"),
                child: const Icon(
                  Icons.shopping_cart,
                ),
              ),
              label: "Cart",
            ),

            const BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
              ),
              activeIcon: Icon(
                Icons.favorite,
              ),
              label: "Favorites",
            ),

            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              activeIcon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}