import 'package:flutter/material.dart';

import '../vendor/vendor_screen.dart';
import '../cart/screens/cart_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';
import 'widgets/search_bar.dart';
import 'widgets/category_card.dart';
import 'widgets/store_card.dart';
import 'widgets/section_title.dart';
import 'widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  String searchQuery = "";
  String selectedCategory = "All";
  final List<Map<String, dynamic>> featuredStores = [
    {
      "image": "assets/stores/mama_nkechi.jpg",
      "name": "Mama Nkechi Kitchen",
      "category": "Food",
      "cuisine": "Nigerian Meals",
      "rating": 4.8,
      "deliveryTime": "25-35 mins",
      "deliveryFee": "₦800",
      "badge": "Top Rated",
    },

    {
      "image": "assets/stores/chicken_republic.jpg",
      "name": "Chicken Republic",
      "category": "Food",
      "cuisine": "Fast Food",
      "rating": 4.7,
      "deliveryTime": "20-30 mins",
      "deliveryFee": "Free",
      "badge": "20% OFF",
    },

    {
      "image": "assets/stores/dominos.jpg",
      "name": "Domino's Pizza",
      "category": "Food",
      "cuisine": "Pizza",
      "rating": 4.9,
      "deliveryTime": "25-35 mins",
      "deliveryFee": "Free",
      "badge": "Best Seller",
    },

    {
      "image": "assets/stores/tantalizers.jpg",
      "name": "Tantalizers",
      "category": "Appetizers",
      "cuisine": "Snacks",
      "rating": 4.6,
      "deliveryTime": "20-30 mins",
      "deliveryFee": "₦600",
      "badge": "Popular",
    },

    {
      "image": "assets/stores/kilimanjaro.jpg",
      "name": "Kilimanjaro",
      "category": "Desserts",
      "cuisine": "Cakes",
      "rating": 4.5,
      "deliveryTime": "30-40 mins",
      "deliveryFee": "₦700",
      "badge": "Sweet",
    },
  ];
  List<Map<String, dynamic>> get filteredStores {
    return featuredStores.where((store) {

      final matchesSearch =
          searchQuery.isEmpty ||
              store["name"]
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery) ||
              store["cuisine"]
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery);

      final matchesCategory =
          selectedCategory == "All" ||
              store["category"] == selectedCategory;

      return matchesSearch && matchesCategory;

    }).toList();
  }
String greeting() {
final hour = DateTime.now().hour;

if (hour < 12) {
return "Good Morning";
}

if (hour < 17) {
return "Good Afternoon";
}

return "Good Evening";
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey.shade50,

  bottomNavigationBar: HomeBottomNav(
    currentIndex: currentIndex,
    onTap: (index) {
      setState(() {
        currentIndex = index;
      });

      switch (index) {

        case 0:
        // Already on Home
          break;

        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const OrdersScreen(),
            ),
          );
          break;

        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CartScreen(),
            ),
          );
          break;

        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );
          break;
      }
    },
  ),

body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 20,
),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Text(
"${greeting()}, Josephine 👋",
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 6),

const Text(
"Deliver to",
style: TextStyle(
color: Colors.grey,
),
),

const SizedBox(height: 4),

const Row(
children: [

Icon(
Icons.location_on,
color: Color(0xFFF57C00),
),

SizedBox(width: 6),

Text(
"Your Address",
style: TextStyle(
fontWeight: FontWeight.w600,
),
),
],
),

const SizedBox(height: 25),

  HomeSearchBar(
    onChanged: (value) {
      setState(() {
        searchQuery = value.toLowerCase();
      });
    },
  ),

  const SizedBox(height: 35),

  const SectionTitle(
    title: "Categories",
  ),

  const SizedBox(height: 18),

  SizedBox(
    height: 120,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [

        CategoryCard(
          icon: Icons.grid_view_rounded,
          title: "All",
          isSelected: selectedCategory == "All",
          onTap: () {
            setState(() {
              selectedCategory = "All";
            });
          },
        ),

        const SizedBox(width: 18),

        CategoryCard(
          icon: Icons.restaurant,
          title: "Food",
          isSelected: selectedCategory == "Food",
          onTap: () {
            setState(() {
              selectedCategory = "Food";
            });
          },
        ),

        const SizedBox(width: 18),

        CategoryCard(
          icon: Icons.fastfood,
          title: "Appetizers",
          isSelected: selectedCategory == "Appetizers",
          onTap: () {
            setState(() {
              selectedCategory = "Appetizers";
            });
          },
        ),

        const SizedBox(width: 18),

        CategoryCard(
          icon: Icons.cake,
          title: "Desserts",
          isSelected: selectedCategory == "Desserts",
          onTap: () {
            setState(() {
              selectedCategory = "Desserts";
            });
          },
        ),

        const SizedBox(width: 18),

        CategoryCard(
          icon: Icons.local_drink,
          title: "Beverages",
          isSelected: selectedCategory == "Beverages",
          onTap: () {
            setState(() {
              selectedCategory = "Beverages";
            });
          },
        ),

      ],
    ),
  ),

const SizedBox(height: 35),

SectionTitle(
title: "Featured Stores",
onSeeAll: () {},
),

const SizedBox(height: 18),

  SizedBox(
    height: 310,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filteredStores.length,
      itemBuilder: (context, index) {
        final store = filteredStores[index];

        return StoreCard(
          image: store["image"],
          name: store["name"],
          category: store["category"],
          rating: store["rating"],
          deliveryTime: store["deliveryTime"],
          deliveryFee: store["deliveryFee"],
          isOpen: true,
          badge: store["badge"],

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VendorScreen(
                  storeName: store["name"],
                  image: store["image"],
                ),
              ),
            );
          },
        );
      },
    ),
  ),

  const SizedBox(height: 35),

  SectionTitle(
    title: "Popular Near You",
    onSeeAll: () {},
  ),

  const SizedBox(height: 18),

  SizedBox(
    height: 310,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [

        StoreCard(
          image: "assets/stores/kilimanjaro.jpg",
          name: "Kilimanjaro",
          category: "African Cuisine",
          rating: 4.6,
          deliveryTime: "30-40 mins",
          deliveryFee: "₦700",
          isOpen: true,
          badge: "Popular",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VendorScreen(
                  storeName: "Kilimanjaro",
                  image: "assets/stores/kilimanjaro.jpg",
                ),
              ),
            );
          },
        ),

        StoreCard(
          image: "assets/stores/tantalizers.jpg",
          name: "Tantalizers",
          category: "Fast Food",
          rating: 4.5,
          deliveryTime: "20-30 mins",
          deliveryFee: "₦600",
          isOpen: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VendorScreen(
                  storeName: "Tantalizers",
                  image: "assets/stores/tantalizers.jpg",
                ),
              ),
            );
          },
        ),
      ],
    ),
  ),

  const SizedBox(height: 30),
],
),
),
),
);
}
}