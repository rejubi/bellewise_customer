import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/errors/error_handler.dart';
import '../../../core/widgets/error_view.dart';

import '../controllers/address_controller.dart';
import '../models/address_model.dart';
import '../widgets/address_card.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({
    super.key,
  });

  @override
  State<AddressesScreen> createState() =>
      _AddressesScreenState();
}

class _AddressesScreenState
    extends State<AddressesScreen> {
  final AddressController controller =
  AddressController();

  late Future<List<AddressModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = controller.loadAddresses();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = controller.loadAddresses();
    });
  }

  Future<void> _delete(int id) async {
    await controller.deleteAddress(id);
    _refresh();
  }

  Future<void> _addAddress() async {
    final result = await context.push(
      "/profile/addresses/add",
    );

    if (result == true && mounted) {
      _refresh();
    }
  }

  void _selectAddress(AddressModel address) {
    context.pop(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Saved Addresses",
        ),
      ),

      body: FutureBuilder<List<AddressModel>>(
        future: _future,
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
              onRetry: _refresh,
            );
          }

          final addresses =
              snapshot.data ?? [];

          if (addresses.isEmpty) {
            return Center(
              child: Padding(
                padding:
                const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 80,
                      color:
                      Colors.grey.shade400,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "No saved addresses yet",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Add your delivery address to make checkout faster.",
                      textAlign:
                      TextAlign.center,
                      style: TextStyle(
                        color: Colors
                            .grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primary,
                          foregroundColor:
                          Colors.white,
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        onPressed: _addAddress,
                        icon: const Icon(
                          Icons.add,
                        ),
                        label: const Text(
                          "Add Address",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding:
              const EdgeInsets.all(16),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.primary,
                      foregroundColor:
                      Colors.white,
                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                    ),
                    onPressed: _addAddress,
                    icon: const Icon(
                      Icons.add,
                    ),
                    label: const Text(
                      "Add New Address",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ...addresses.map(
                      (item) => Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                      onTap: () =>
                          _selectAddress(item),
                      child: AddressCard(
                        address: item,
                        onDelete: () {
                          _delete(item.id);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}