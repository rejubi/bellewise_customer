import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/providers/cart_provider.dart';

class HomeBottomNav extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(cartProvider.notifier);
    final cartCount = notifier.itemCount;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,

      selectedItemColor: const Color(0xFFF57C00),
      unselectedItemColor: Colors.grey,

      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),

      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: "Home",
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Orders",
        ),

        BottomNavigationBarItem(
          label: "Cart",
          icon: Stack(
            clipBehavior: Clip.none,
            children: [

              const Icon(Icons.shopping_cart),

              if (cartCount > 0)
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartCount > 99 ? "99+" : "$cartCount",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}