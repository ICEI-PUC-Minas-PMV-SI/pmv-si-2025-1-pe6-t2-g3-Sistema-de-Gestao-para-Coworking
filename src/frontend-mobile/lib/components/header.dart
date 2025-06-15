import 'package:flutter/material.dart';
import 'package:coworking_app/utils/app_colors.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onProfileTap;
  final List<Widget>? actions;

  const CustomHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onProfileTap,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBarTheme = theme.appBarTheme;

    return AppBar(
      backgroundColor: appBarTheme.backgroundColor,
      foregroundColor: appBarTheme.foregroundColor,
      elevation: appBarTheme.elevation,
      iconTheme: appBarTheme.iconTheme,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title,
        style: appBarTheme.titleTextStyle,
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: false,
      actions: [
        ...?actions,
        IconButton(
          icon: const Icon(Icons.notifications_none),
          tooltip: 'Notificações',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Funcionalidade de notificações não implementada.')),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 4.0),
          child: GestureDetector(
            onTap: onProfileTap ??
                () {
                  Navigator.pushNamed(context, '/profile');
                },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryOrange,
              child: const Icon(
                Icons.person_outline,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


