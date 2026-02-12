import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_note_app/providers/task_provider.dart';

class ProfileHeader extends StatelessWidget {
  final File? profileImage;
  final TextEditingController bioController;
  final TextEditingController nameController;
  final bool isEditingName;
  final VoidCallback onPickImage;
  final VoidCallback onUpdateName;

  const ProfileHeader({
    super.key,
    required this.profileImage,
    required this.bioController,
    required this.nameController,
    required this.isEditingName,
    required this.onPickImage,
    required this.onUpdateName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Hero(
                tag: 'profile_avatar',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF15B86C).withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: const Color(0xFF15B86C),
                    child: CircleAvatar(
                      radius: 57,
                      backgroundColor: Colors.grey.shade900,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : const AssetImage("assets/images/car.jpg"),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: onPickImage,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF15B86C), Color(0xFF0F8A52)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          isEditingName
              ? _buildNameEditField()
              : Consumer<TaskProvider>(
                  builder: (context, provider, _) => Column(
                    children: [
                      Text(
                        provider.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bioController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xffC6C6C6),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildNameEditField() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      child: TextField(
        controller: nameController,
        autofocus: true,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => onUpdateName(),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF282828),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF15B86C)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF15B86C), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
