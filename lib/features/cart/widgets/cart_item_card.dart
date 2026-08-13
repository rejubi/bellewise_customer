import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final currentPrice = item.currentPrice;
    final hasDiscount = item.hasDiscount;

    return Dismissible(
      key: ValueKey(item.id),

      direction:
      DismissDirection.endToStart,

      background: Container(
        margin:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        padding:
        const EdgeInsets.only(
          right: 24,
        ),
        alignment:
        Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius:
          BorderRadius.circular(14),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),

      onDismissed: (_) => onRemove(),

      child: Card(
        elevation: 1,
        margin:
        const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(14),
        ),

        child: Padding(
          padding:
          const EdgeInsets.all(10),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              // ==================================================
              // PRODUCT IMAGE
              // ==================================================

              ClipRRect(
                borderRadius:
                BorderRadius.circular(10),

                child: item.image != null &&
                    item.image!.isNotEmpty
                    ? Image.network(
                  item.image!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,

                  errorBuilder:
                      (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return Container(
                      width: 60,
                      height: 60,
                      color:
                      Colors.grey.shade200,
                      child:
                      const Icon(
                        Icons.fastfood,
                        color: Colors.grey,
                        size: 28,
                      ),
                    );
                  },
                )
                    : Container(
                  width: 60,
                  height: 60,
                  color:
                  Colors.grey.shade200,
                  child:
                  const Icon(
                    Icons.fastfood,
                    color: Colors.grey,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ==================================================
              // PRODUCT INFORMATION
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,

                      style:
                      const TextStyle(
                        fontSize: 15,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      item.description,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12,
                        color:
                        Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // ==================================================
                    // PRICE + QUANTITY
                    // ==================================================

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisSize:
                            MainAxisSize.min,
                            children: [
                              // CURRENT PRICE
                              Text(
                                "₦${currentPrice.toStringAsFixed(0)}",

                                style:
                                const TextStyle(
                                  color:
                                  AppColors
                                      .primary,
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              // ORIGINAL PRICE
                              if (hasDiscount)
                                Text(
                                  "₦${item.price.toStringAsFixed(0)}",

                                  style:
                                  const TextStyle(
                                    color:
                                    Colors.grey,
                                    fontSize: 12,
                                    decoration:
                                    TextDecoration
                                        .lineThrough,
                                    decorationColor:
                                    Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // ==================================================
                        // QUANTITY CONTROLS
                        // ==================================================

                        Container(
                          height: 34,

                          decoration:
                          BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                              18,
                            ),
                            border:
                            Border.all(
                              color:
                              Colors.grey
                                  .shade300,
                            ),
                          ),

                          child: Row(
                            mainAxisSize:
                            MainAxisSize.min,

                            children: [
                              InkWell(
                                onTap:
                                onDecrease,

                                child:
                                const SizedBox(
                                  width: 32,
                                  child:
                                  Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                ),
                              ),

                              Padding(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 6,
                                ),

                                child: Text(
                                  item.quantity
                                      .toString(),

                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap:
                                onIncrease,

                                child:
                                const SizedBox(
                                  width: 32,
                                  child:
                                  Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}