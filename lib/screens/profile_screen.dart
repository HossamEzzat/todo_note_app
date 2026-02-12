import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';

import '../widgets/detailed_stats.dart';
import '../widgets/profile_dialogs.dart';
import '../widgets/profile_header.dart';
import '../widgets/quick_stats.dart';
import '../widgets/section_title.dart';
import '../widgets/settings_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isEditingName = false;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController(
      text: "One task at a time. One step closer.",
    );

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final name = context.read<TaskProvider>().userName;
      _nameController.text = name;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated!'),
              backgroundColor: Color(0xFF15B86C),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to pick image'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  void _updateName() {
    final text = _nameController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name cannot be empty'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    context.read<TaskProvider>().updateUserName(text);
    setState(() => _isEditingName = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Name updated successfully!'),
        backgroundColor: Color(0xFF15B86C),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditingName ? Icons.check : Icons.edit,
              color: _isEditingName ? const Color(0xFF15B86C) : Colors.white70,
            ),
            onPressed: () {
              if (_isEditingName) {
                _updateName();
              } else {
                setState(() => _isEditingName = true);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(
                  profileImage: _profileImage,
                  bioController: _bioController,
                  nameController: _nameController,
                  isEditingName: _isEditingName,
                  onPickImage: _pickImage,
                  onUpdateName: _updateName,
                ),
                const SizedBox(height: 32),
                const QuickStats(),
                const SizedBox(height: 32),
                const SectionTitle(title: "Account Settings"),
                const SizedBox(height: 12),
                SettingsCard(
                  onUserDetailsPressed: () =>
                      ProfileDialogs.showUserDetailsDialog(context),
                  onLogoutPressed: () =>
                      ProfileDialogs.showLogoutDialog(context),
                ),
                const SizedBox(height: 32),
                const SectionTitle(title: "Statistics"),
                const SizedBox(height: 12),
                const DetailedStats(),
                const SizedBox(height: 32),
                _buildResetButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
      ),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () => ProfileDialogs.showResetDialog(context),
        icon: const Icon(Icons.delete_forever, size: 22),
        label: const Text(
          "Reset All Data",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
