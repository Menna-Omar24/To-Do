import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  static void showMessageDialog(
    BuildContext context, {
    required String message,
    String? positiveActionTitle,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          if (positiveActionTitle != null) ...[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ],
      ),
    );
  }
}
