import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends State<ChangePasswordScreen> {
  late final ChangePasswordController controller;

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();

    controller = ChangePasswordController();
    controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();

    super.dispose();
  }

  Future<void> _changePassword() async {
    final message = await controller.changePassword();

    if (!mounted) return;

    if (message == null) {
      return;
    }

    // Successful response from Django.
    if (message == "Password changed successfully.") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the fields after successful change.
      controller.currentPasswordController.clear();
      controller.newPasswordController.clear();
      controller.confirmPasswordController.clear();

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: IconButton(
        icon: Icon(
          obscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: onToggle,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE67E22),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // ==========================================
              // ICON
              // ==========================================

              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE67E22)
                        .withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 40,
                    color: Color(0xFFE67E22),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Change your password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Enter your current password and choose a new password for your account.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

              // ==========================================
              // CURRENT PASSWORD
              // ==========================================

              TextField(
                controller:
                controller.currentPasswordController,
                obscureText: _obscureCurrent,
                enabled: !controller.isLoading,
                textInputAction: TextInputAction.next,
                decoration: _decoration(
                  label: "Current Password",
                  icon: Icons.lock_outline,
                  obscure: _obscureCurrent,
                  onToggle: () {
                    setState(() {
                      _obscureCurrent =
                      !_obscureCurrent;
                    });
                  },
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // NEW PASSWORD
              // ==========================================

              TextField(
                controller:
                controller.newPasswordController,
                obscureText: _obscureNew,
                enabled: !controller.isLoading,
                textInputAction: TextInputAction.next,
                decoration: _decoration(
                  label: "New Password",
                  icon: Icons.lock_reset_outlined,
                  obscure: _obscureNew,
                  onToggle: () {
                    setState(() {
                      _obscureNew = !_obscureNew;
                    });
                  },
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Password must be at least 8 characters.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 18),

              // ==========================================
              // CONFIRM PASSWORD
              // ==========================================

              TextField(
                controller:
                controller.confirmPasswordController,
                obscureText: _obscureConfirm,
                enabled: !controller.isLoading,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!controller.isLoading) {
                    _changePassword();
                  }
                },
                decoration: _decoration(
                  label: "Confirm New Password",
                  icon: Icons.lock_reset_outlined,
                  obscure: _obscureConfirm,
                  onToggle: () {
                    setState(() {
                      _obscureConfirm =
                      !_obscureConfirm;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ==========================================
              // CHANGE PASSWORD BUTTON
              // ==========================================

              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed:
                  controller.isLoading
                      ? null
                      : _changePassword,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                    const Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================
              // CANCEL
              // ==========================================

              TextButton(
                onPressed: controller.isLoading
                    ? null
                    : () {
                  context.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFFE67E22),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}