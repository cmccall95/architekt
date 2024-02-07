import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog._({
    required this.title,
    required this.message,
    this.onClose,
  });

  final String title;
  final String message;
  final VoidCallback? onClose;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onClose,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog._(
          title: title,
          message: message,
          onClose: onClose,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onClose?.call();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
