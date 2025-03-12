import 'package:flutter/material.dart';

class LoadingOverlay {
  // Create a global key for the overlay
  static final GlobalKey<_LoadingOverlayState> _overlayKey =
      GlobalKey<_LoadingOverlayState>();

  // Function to show the overlay
  static void show(BuildContext context) {
    if (_overlayKey.currentState != null) {
      _overlayKey.currentState!.showOverlay();
    }
  }

  // Function to hide the overlay
  static void hide() {
    if (_overlayKey.currentState != null) {
      _overlayKey.currentState!.hideOverlay();
    }
  }

  // Attach the overlay to the app (call this in your root widget)
  static Widget withOverlay(Widget child) {
    return Stack(
      children: [
        child, // Main app content
        _LoadingOverlay(key: _overlayKey), // Loading overlay
      ],
    );
  }
}

class _LoadingOverlay extends StatefulWidget {
  const _LoadingOverlay({super.key});

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<_LoadingOverlay> {
  bool _isVisible = false;

  // Show overlay method
  void showOverlay() {
    setState(() {
      _isVisible = true;
    });
  }

  // Hide overlay method
  void hideOverlay() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          )
        : const SizedBox.shrink(); // No widget if not visible
  }
}
