import 'package:flutter/material.dart';

import '../controllers/app_management_controller.dart';

class AppContentScreen
    extends StatefulWidget {

  final String title;
  final String slug;
  final AppManagementController controller;

  const AppContentScreen({
    super.key,
    required this.title,
    required this.slug,
    required this.controller,
  });

  @override
  State<AppContentScreen> createState() =>
      _AppContentScreenState();
}

class _AppContentScreenState
    extends State<AppContentScreen> {

  bool isLoading = true;
  String? error;
  String content = "";

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {

    setState(() {
      isLoading = true;
      error = null;
    });

    final result =
    await widget.controller
        .getContentBySlug(
      widget.slug,
    );

    if (!mounted) {
      return;
    }

    if (result == null) {
      setState(() {
        error =
        "This information is currently unavailable.";
        isLoading = false;
      });

      return;
    }

    setState(() {
      content = result.content;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    if (isLoading) {
      return const Center(
        child:
        CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding:
          const EdgeInsets.all(24),
          child: Column(
            mainAxisSize:
            MainAxisSize.min,
            children: [

              const Icon(
                Icons.info_outline,
                size: 48,
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                error!,
                textAlign:
                TextAlign.center,
              ),

              const SizedBox(
                height: 16,
              ),

              ElevatedButton(
                onPressed: _load,
                child:
                const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,

      child: SingleChildScrollView(
        physics:
        const AlwaysScrollableScrollPhysics(),

        padding:
        const EdgeInsets.all(20),

        child: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            height: 1.7,
          ),
        ),
      ),
    );
  }
}