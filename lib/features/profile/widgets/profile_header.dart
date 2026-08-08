import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeader({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final fullName = [
      profile.firstName.trim(),
      profile.lastName.trim(),
    ].where((name) => name.isNotEmpty).join(' ');

    final displayName = fullName.isNotEmpty
        ? fullName
        : profile.displayName.isNotEmpty
        ? profile.displayName
        : 'BelleWise Customer';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          // ====================================================
          // PROFILE AVATAR
          // ====================================================

          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              size: 52,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 16),

          // ====================================================
          // CUSTOMER NAME
          // ====================================================

          Text(
            displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          // ====================================================
          // CUSTOMER ID
          // ====================================================

          Text(
            'Customer ID: ${profile.publicId}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 24),

          // ====================================================
          // PERSONAL INFORMATION
          // ====================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'First Name',
                  value: profile.firstName,
                ),

                const SizedBox(height: 14),

                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Last Name',
                  value: profile.lastName,
                ),

                const SizedBox(height: 14),

                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: profile.email,
                ),

                const SizedBox(height: 14),

                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone Number',
                  value: profile.phoneNumber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFORMATION ROW
// ============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value.trim().isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                hasValue ? value : 'Not provided',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  hasValue ? FontWeight.w600 : FontWeight.normal,
                  color:
                  hasValue ? Colors.black87 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}