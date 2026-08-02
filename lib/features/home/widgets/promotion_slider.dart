import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/promotion_model.dart';

class PromotionSlider extends StatefulWidget {
  final List<PromotionModel> promotions;

  const PromotionSlider({
    super.key,
    required this.promotions,
  });

  @override
  State<PromotionSlider> createState() => _PromotionSliderState();
}

class _PromotionSliderState extends State<PromotionSlider> {
  late final PageController _controller;

  Timer? _timer;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      viewportFraction: 0.94,
    );

    if (widget.promotions.length > 1) {
      _timer = Timer.periodic(
        const Duration(seconds: 4),
            (_) {
          if (!mounted) return;

          _currentPage++;

          if (_currentPage >= widget.promotions.length) {
            _currentPage = 0;
          }

          _controller.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 175,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.promotions.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (_, index) {
              final promo = widget.promotions[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        promo.image,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(.75),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Text(
                                promo.vendorName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              promo.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            if (promo.subtitle.isNotEmpty)
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                  top: 4,
                                ),
                                child: Text(
                                  promo.subtitle,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.promotions.length,
                (index) {
              final selected = index == _currentPage;

              return AnimatedContainer(
                duration:
                const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                height: 8,
                width: selected ? 24 : 8,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary
                      : Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}