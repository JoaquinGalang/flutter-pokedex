import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kGrayColor200,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kGrayColor400,
            offset: Offset(1, 1),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          size: 30,
        ),
      ),
    );
  }
}