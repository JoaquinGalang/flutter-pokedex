import 'package:flutter/material.dart';
import 'package:flutter_pokedex/widgets/pokeball_loading_indicator.dart';

class LoadMoreButton extends StatefulWidget {
  LoadMoreButton({
    super.key,
    required this.onPressed,
  });

  final Future<void> Function() onPressed;

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: (_isLoading)
          ? const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Center(
                child: PokeballLoadingIndicator(size: 50),
              ),
          )
          : GestureDetector(
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                await widget.onPressed();
              },
              child: Container(
                width: double.infinity,
                height: 60,
                color: Colors.redAccent,
                child: const Center(
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
