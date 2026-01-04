import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Clean, minimal background - no flashy animations or shapes
class PremiumBackground extends StatelessWidget {
  final Widget child;
  
  const PremiumBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgPrimary,
      child: child,
    );
  }
}

/// Simple card container - clean borders, no glows
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = AppTheme.radiusLg,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.bgSecondary,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppTheme.border,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppTheme.spaceMd),
          child: child,
        ),
      ),
    );
  }
}

/// Clean button - solid color, no excessive shadows or glows
class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double height;
  final IconData? icon;
  
  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.height = 52,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppTheme.primary,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
