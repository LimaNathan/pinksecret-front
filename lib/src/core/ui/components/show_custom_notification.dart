import 'package:flutter/material.dart';
import 'package:pinksecret_front/src/core/ui/components/custom_notification.dart';

void showCustomNotification(BuildContext context, String message) {
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => GestureDetector(
      onTap: () =>
          overlayEntry.remove(), // Usa overlayEntry após ele ser definido
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: Container(
          //     color: Colors.black54,
          //   ),
          // ),

          Align(
            alignment: Alignment.topRight,
            child: CustomNotification(
              message: message,
              duration: const Duration(seconds: 5),
              onComplete: () {
                overlayEntry.remove();
              },
            ),
          ),
        ],
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);
}
