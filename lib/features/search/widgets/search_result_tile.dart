import 'package:flutter/material.dart';

class SearchResultTile
    extends StatelessWidget {

  final String title;

  final String subtitle;

  final String? image;

  final IconData icon;

  const SearchResultTile({

    super.key,

    required this.title,

    required this.subtitle,

    required this.image,

    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: image != null

          ? ClipRRect(

        borderRadius:
        BorderRadius.circular(8),

        child: Image.network(
          image!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      )

          : CircleAvatar(
        child: Icon(icon),
      ),

      title: Text(title),

      subtitle: Text(subtitle),
    );
  }
}