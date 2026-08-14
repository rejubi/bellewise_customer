import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/search_api_controller.dart';
import '../models/search_model.dart';
import '../widgets/search_result_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchApiController controller =
  SearchApiController();

  final TextEditingController textController =
  TextEditingController();

  Timer? debounce;

  SearchModel? result;

  bool loading = false;

  // ==========================================================
  // SEARCH
  // ==========================================================

  void search(String value) {
    debounce?.cancel();

    debounce = Timer(
      const Duration(milliseconds: 400),
          () async {
        if (value.trim().isEmpty) {
          setState(() {
            result = null;
            loading = false;
          });

          return;
        }

        setState(() {
          loading = true;
        });

        final response =
        await controller.search(value);

        if (!mounted) return;

        setState(() {
          result = response;
          loading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    textController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),

      body: Column(
        children: [
          // ====================================================
          // SEARCH FIELD
          // ====================================================

          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: textController,
              autofocus: true,
              onChanged: search,
              decoration: InputDecoration(
                hintText:
                "Search meals or restaurants",

                prefixIcon: const Icon(
                  Icons.search,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // ====================================================
          // LOADING
          // ====================================================

          if (loading)
            const LinearProgressIndicator(),

          // ====================================================
          // RESULTS
          // ====================================================

          Expanded(
            child: result == null
                ? const Center(
              child: Text(
                "Start typing...",
              ),
            )
                : ListView(
              children: [
                // ========================================
                // RESTAURANTS
                // ========================================

                if (result!
                    .restaurants
                    .isNotEmpty)
                  const Padding(
                    padding:
                    EdgeInsets.all(16),
                    child: Text(
                      "Restaurants",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ...result!.restaurants.map(
                      (e) => SearchResultTile(
                    title: e.businessName,
                    subtitle: e.address,
                    image: e.logo,
                    icon: Icons.store,

                    // Vendor navigation will be
                    // connected once we confirm
                    // your vendor route.
                  ),
                ),

                // ========================================
                // CATEGORIES
                // ========================================

                if (result!
                    .categories
                    .isNotEmpty)
                  const Padding(
                    padding:
                    EdgeInsets.all(16),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ...result!.categories.map(
                      (e) => SearchResultTile(
                    title: e.name,
                    subtitle:
                    e.description,
                    image: e.image,
                    icon:
                    Icons.category,
                  ),
                ),

                // ========================================
                // MEALS
                // ========================================

                if (result!
                    .meals
                    .isNotEmpty)
                  const Padding(
                    padding:
                    EdgeInsets.all(16),
                    child: Text(
                      "Meals",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ...result!.meals.map(
                      (e) => SearchResultTile(
                    title: e.name,
                    subtitle: e.vendor,
                    image: e.image,
                    icon:
                    Icons.restaurant,

                    // Meal → Product Detail
                    onTap: () {
                      context.push(
                        "/product/${e.id}",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}