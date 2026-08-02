import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class BannerSlider extends StatelessWidget {
  final List banners;

  const BannerSlider({
    super.key,
    required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: banner is Map && banner["image"] != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              banner["image"],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
              : Center(
            child: Text(
              banner is Map
                  ? (banner["title"] ?? "")
                  : banner.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 170,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.92,
      ),
    );
  }
}