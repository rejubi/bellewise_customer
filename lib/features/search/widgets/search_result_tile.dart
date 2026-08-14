import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? image;
  final IconData icon;
  final VoidCallback? onTap;

  const SearchResultTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,

      leading: image != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          image!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return CircleAvatar(
              child: Icon(icon),
            );
          },
        ),
      )
          : CircleAvatar(
        child: Icon(icon),
      ),

      title: Text(title),

      subtitle: Text(subtitle),

      trailing: const Icon(
        Icons.chevron_right,
      ),
    );
  }
}