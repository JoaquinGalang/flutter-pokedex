import 'package:flutter/material.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.redAccent,
          child: (isLoading)
              ? const CircularProgressIndicator()
              : const Center(
                  child: Text(
                    'Load More',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
