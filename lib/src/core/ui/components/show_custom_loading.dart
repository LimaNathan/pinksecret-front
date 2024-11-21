import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/loading_component.dart';
import 'package:pinksecret_front/src/shared/utils/constants/image_constants.dart';

class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();
  factory LoadingOverlay() => _instance;

  static OverlayEntry? _overlayEntry;

  LoadingOverlay._internal();

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;
    final width = MediaQuery.sizeOf(context).width;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black54,
              ),
            ),
            Center(
              child: LoadingWithTypingEffect(
                imagePath: ImageConstants.logoResumida,
                imageSize: width * .3,
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  bool get isVisible => _overlayEntry != null;
}
