import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';
import '../controllers/category_products_controller.dart';
import '../models/category_products_model.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState
    extends State<CategoryProductsScreen> {
final CategoryProductsController controller =
CategoryProductsController();

late Future<CategoryProductsModel> future;

@override
void initState() {
super.initState();

future = controller.loadCategory(
widget.categoryId,
);
}

Future<void> _reload() async {
setState(() {
future = controller.loadCategory(
widget.categoryId,
);
});

await future;
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: AppColors.background,

body: FutureBuilder<CategoryProductsModel>(
future: future,
builder: (context, snapshot) {

if (snapshot.connectionState ==
ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(),
);
}

if (snapshot.hasError) {
return ErrorView(
message: ErrorHandler.getMessage(
snapshot.error,
),
onRetry: _reload,
);
}

if (!snapshot.hasData) {
return ErrorView(
message: "Category not found.",
onRetry: _reload,
);
}

final data = snapshot.data!;

return RefreshIndicator(
onRefresh: _reload,
child: CustomScrollView(
physics:
const AlwaysScrollableScrollPhysics(),
slivers: [

SliverAppBar(
expandedHeight: 230,
pinned: true,
backgroundColor: AppColors.primary,

flexibleSpace: FlexibleSpaceBar(
title: Text(
data.category.name,
),

background: data.category.image == null
? Container(
color: AppColors.primary,
child: const Center(
child: Icon(
Icons.fastfood,
color: Colors.white,
size: 80,
),
),
)
: Image.network(
data.category.image!,
fit: BoxFit.cover,
),
),
),

SliverToBoxAdapter(
child: Padding(
padding:
const EdgeInsets.all(20),
child: Text(
data.category.description,
style: const TextStyle(
fontSize: 15,
color: Colors.grey,
),
),
),
),

if (data.products.isEmpty)
const SliverFillRemaining(
child: Center(
child: Text(
"No products available",
),
),
)
else
SliverPadding(
padding:
const EdgeInsets.symmetric(
horizontal: 16,
),
sliver: SliverGrid(
delegate:
SliverChildBuilderDelegate(
(context, index) {
final product =
data.products[index];
return Card(
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius:
    BorderRadius.circular(16),
  ),
  child: InkWell(
    borderRadius:
    BorderRadius.circular(16),
    onTap: () {
      context.push(
        "/product/${product.id}",
      );
    },
    child: Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: product.image == null
                ? const Center(
              child: Icon(
                Icons.fastfood,
                size: 50,
              ),
            )
                : Image.network(
              product.image!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Padding(
          padding:
          const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                product.name,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                product.vendorName,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                  Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "₦${(product.discountPrice ?? product.price).toStringAsFixed(0)}",
                style: const TextStyle(
                  color:
                  AppColors.primary,
                  fontWeight:
                  FontWeight.bold,
                  fontSize: 18,
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
  childCount: data.products.length,
),
  gridDelegate:
  const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: .72,
  ),
),
),

  const SliverToBoxAdapter(
    child: SizedBox(height: 20),
  ),
],
),
);
},
),
);
}
}