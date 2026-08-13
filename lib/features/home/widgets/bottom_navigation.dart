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
        final count =
            CartState.instance.itemCount;

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                offset: Offset(0, -3),
                color: Colors.black12,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,

              backgroundColor:
              AppColors.primary,

              elevation: 0,

              showUnselectedLabels: true,

              selectedItemColor:
              Colors.white,

              unselectedItemColor:
              Colors.white70,

              selectedLabelStyle:
              const TextStyle(
                fontWeight: FontWeight.w600,
              ),

              unselectedLabelStyle:
              const TextStyle(
                fontWeight: FontWeight.w400,
              ),

              items: [
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                  ),
                  label: "Home",
                ),

                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.receipt_long_outlined,
                  ),
                  activeIcon: Icon(
                    Icons.receipt_long,
                  ),
                  label: "Orders",
                ),

                BottomNavigationBarItem(
                  icon: Badge(
                    isLabelVisible:
                    count > 0,
                    label: Text("$count"),
                    child: const Icon(
                      Icons
                          .shopping_cart_outlined,
                    ),
                  ),
                  activeIcon: Badge(
                    isLabelVisible:
                    count > 0,
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
            ),
          ),
        );
      },
    );
  }
}