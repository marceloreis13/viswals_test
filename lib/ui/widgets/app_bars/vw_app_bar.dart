import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final Color backgroundColor;
  final List<Widget>? actions;

  const VwAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor = VwColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
