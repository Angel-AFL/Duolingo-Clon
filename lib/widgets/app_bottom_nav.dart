import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../models/nav_item.dart';

/// Barra de navegacion inferior de la app (tema oscuro).
///
/// El item activo se marca con un contorno de 12px de radio en su color de
/// acento, como en los bocetos.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    this.onTap,
  });

  final List<NavItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        border: Border(
          top: BorderSide(color: AppColors.darkBorder),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (int i = 0; i < items.length; i++)
                _NavButton(
                  item: items[i],
                  selected: i == selectedIndex,
                  onTap: onTap == null ? null : () => onTap!(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    this.onTap,
  });

  final NavItem item;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.standard),
      child: Container(
        width: 56,
        height: 44,
        decoration: selected
            ? BoxDecoration(
                border: Border.all(color: item.color, width: 2),
                borderRadius: BorderRadius.circular(AppRadius.standard),
              )
            : null,
        child: Icon(
          item.icon,
          size: 28,
          color: selected
              ? item.color
              : item.color.withValues(alpha: 0.55),
        ),
      ),
    );
  }
}
