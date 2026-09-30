import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// The YumQuick page style used by every screen:
/// yellow header (back arrow + title) and a white body with round top corners.
class CurvedPage extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? header;
  final Widget? action;
  final bool showBack;
  final EdgeInsetsGeometry bodyPadding;

  const CurvedPage({
    super.key,
    required this.body,
    this.title = '',
    this.header,
    this.action,
    this.showBack = true,
    this.bodyPadding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerYellow,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: header ?? _titleRow(context),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: bodyPadding,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleRow(BuildContext context) {
    return Row(
      children: [
        showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              )
            : const SizedBox(width: 48),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        action ?? const SizedBox(width: 48),
      ],
    );
  }
}
