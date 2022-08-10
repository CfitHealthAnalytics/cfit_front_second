import 'package:flutter/material.dart';

class ListTileCfit extends StatelessWidget {
  const ListTileCfit({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.leading,
    this.subtitle,
    this.customPadding = 16.0,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final VoidCallback onPressed;
  final Widget leading;
  final double customPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          : null,
      leading: leading,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(
        vertical: customPadding,
        horizontal: 12.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
