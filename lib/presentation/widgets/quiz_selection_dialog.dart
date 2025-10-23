

import 'package:flutter/material.dart';

import '../../core/constants/studify_colors.dart';
import '../screens/study_mode_overview_screen.dart';


class QuizSelectionDialog extends StatelessWidget {
  const QuizSelectionDialog({super.key});

  Widget _buildQuizOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBackgroundColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            // Icon with Background Circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use a Column inside a Container to create the rounded-corner card look
    // and an outer Padding to center the close button below it.
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Space for the close button
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keep column size minimal
        children: [
          // The main dialog box content
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuizOption(
                  title: 'Study mode',
                  subtitle: 'Learn at your pace. No pressure.',
                  icon: Icons.school,
                  iconColor: const Color(0xFFF56A00), // Orange
                  iconBackgroundColor: StudifyColors.studyModeIconBg,
                  onTap: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StudyModeOverviewScreen(
                          quizTitle: 'Assembly Programming Guide',
                        ),
                      ),
                    );
                  },
                ),
                // Divider(color: Colors.grey.shade200, height: 1),
                _buildQuizOption(
                  title: 'Single Quiz',
                  subtitle: 'Test your speed and accuracy.',
                  icon: Icons.person,
                  iconColor: const Color(0xFFE91E63), // Pink
                  iconBackgroundColor: StudifyColors.singleQuizIconBg,
                  onTap: () {
                    Navigator.pop(context); // Close dialog
                    // TODO: Implement navigation to Single Quiz
                  },
                ),
                // Divider(color: Colors.grey.shade200, height: 1),
                _buildQuizOption(
                  title: 'Competition Quiz',
                  subtitle: 'Compete with peers, climb the ranks.',
                  icon: Icons.group,
                  iconColor: const Color(0xFF2196F3), // Blue
                  iconBackgroundColor: StudifyColors.competitionIconBg,
                  onTap: () {
                    Navigator.pop(context); // Close dialog
                    // TODO: Implement navigation to Competition Quiz
                  },
                ),
              ],
            ),
          ),

          // Close button (X) below the dialog
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context), // Close dialog when X is tapped
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFF757575), // Medium grey color
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}