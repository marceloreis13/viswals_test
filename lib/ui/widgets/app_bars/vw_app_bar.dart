import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final Color backgroundColor;

  const VwAppBar({
    super.key,
    required this.title,
    this.leading,
    this.backgroundColor = VwColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
