import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';

class PhysicalQuantityCard extends StatelessWidget {
  const PhysicalQuantityCard({
    super.key,
    required this.quantity,
    required this.type,
  });

  final String quantity;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: kGrayColor200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quantity,
                style: const TextStyle(
                  color: kGrayColor600,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                type,
                style: const TextStyle(
                  color: kGrayColor500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}