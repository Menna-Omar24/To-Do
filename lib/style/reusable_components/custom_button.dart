import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function() onPress;
  String title;

  CustomButton({
    super.key,
    required this.onPress,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height * 0.01),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: height * 0.02,
          vertical: height * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
