import 'package:flutter/material.dart';

class ExitAppButton extends StatelessWidget {
  const ExitAppButton({super.key});

  void closeApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'If you press yes then application will close and you will have to manually restart the app',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // exit(0);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () => closeApp(context),
        label: const Text('Exit'),
        icon: const Icon(Icons.exit_to_app),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
