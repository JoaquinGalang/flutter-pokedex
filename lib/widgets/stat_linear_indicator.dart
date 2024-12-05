import 'package:flutter/material.dart';
import 'package:flutter_pokedex/utils/constants.dart';

class StatLinearIndicator extends StatelessWidget {
  const StatLinearIndicator({
    super.key,
    required this.stat,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  final String stat;
  final double value;
  final double maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(stat, style: kLightGrayDefaultTextStyle),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: LinearProgressIndicator(
                color: color,
                backgroundColor: kGrayColor200,
                minHeight: 8,
                value: value / maxValue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
