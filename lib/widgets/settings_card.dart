import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final VoidCallback onUserDetailsPressed;
  final VoidCallback onLogoutPressed;

  const SettingsCard({
    super.key,
    required this.onUserDetailsPressed,
    required this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.person_outline,
            title: "User Details",
            onTap: onUserDetailsPressed,
          ),
          _buildDivider(),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: "Dark Mode",
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: const Color(0xFF15B86C),
            ),
          ),
          _buildDivider(),
          _buildDivider(),
          _SettingsTile(
            icon: Icons.logout,
            title: "Log Out",
            onTap: onLogoutPressed,
            textColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.white.withValues(alpha: 0.1),
        thickness: 1,
        height: 1,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? textColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Icon(
        icon,
        color: textColor ?? const Color(0xFF15B86C),
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          Icon(CupertinoIcons.right_chevron, color: Colors.white54, size: 18),
      onTap: onTap,
    );
  }
}
