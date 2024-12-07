import 'package:flutter/material.dart';

class AbilityLink extends StatelessWidget {
  const AbilityLink({
    super.key,
    required this.ability,
    required this.brightColor,
    required this.onTap,
  });

  final String ability;
  final Color? brightColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '\t• $ability ',
            style: TextStyle(
              color: brightColor,
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.help_outline,
            size: 18,
            color: brightColor,
          ),
        ],
      ),
    );
  }
}