import 'package:flutter/material.dart';

class ErrorSnackbar {
  static show(BuildContext context, {String? message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Aconteceu um erro'),
        backgroundColor: Theme.of(context).colorScheme.error,
        width: MediaQuery.sizeOf(context).width * .33,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
