import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_notification.dart';

void showCustomNotification(
  BuildContext context, {
  required String message,
  Color? color,
}) {
  OverlayEntry? overlayEntry;
  // ignore: unnecessary_null_comparison
  if (overlayEntry != null) {
    return;
  }

  overlayEntry = OverlayEntry(
    builder: (context) {
      return GestureDetector(
        onTap: () => overlayEntry?.remove(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black12,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CustomNotification(
                color: color,
                message: message,
                duration: const Duration(seconds: 5),
                onComplete: () {
                  overlayEntry?.remove();
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  Overlay.of(context).insert(overlayEntry);
}
