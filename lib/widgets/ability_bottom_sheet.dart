import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';

class AbilityBottomSheet extends StatelessWidget {
  const AbilityBottomSheet({
    super.key,
    required this.ability,
    required this.description,
    required this.color,
  });

  final String ability;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(90),
          topRight: Radius.circular(90),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: kGrayColor400,
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              ability,
              style: kAbilityTitleTextStyle.copyWith(color: color),
            ),
            const SizedBox(height: 10),
            Text(description, style: kGrayDefaultTextStyle),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
