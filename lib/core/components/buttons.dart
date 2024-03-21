import 'package:flutter/material.dart';

import '../constants/colors.dart';

enum ButtonStyle {
  filled,
  outlined,
}

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = ButtonStyle.filled,
    this.color = AppColors.primary,
    this.width = double.infinity,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.icon,
  });

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.child,
    this.style = ButtonStyle.outlined,
    this.color = AppColors.white,
    this.width = double.infinity,
    this.height = 48.0,
    this.borderRadius = 12.0,
    this.icon,
  });

  final Function() onPressed;
  final Widget child;
  final ButtonStyle style;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: style == ButtonStyle.filled
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  child,
                ],
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                side: const BorderSide(
                  color: AppColors.primary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox.shrink(),
                  if (icon != null) const SizedBox(width: 10.0),
                  child
                ],
              ),
            ),
    );
  }
}
