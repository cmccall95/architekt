import 'package:flutter/material.dart';

class RequestDialog extends StatelessWidget {
  const RequestDialog._({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    final agree = await showDialog<bool>(
      context: context,
      builder: (context) => RequestDialog._(
        title: title,
        message: message,
      ),
    );

    return agree is bool && agree;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
