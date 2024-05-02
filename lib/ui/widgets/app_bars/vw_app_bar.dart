import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VwAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = VwColors.primary,
  });

  final Widget title;
  final List<Widget>? actions;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
