import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Rounded full-width button. Shows a spinner while [isLoading] is true.
class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryOrange,
    this.textColor = Colors.white,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(color: textColor, strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
