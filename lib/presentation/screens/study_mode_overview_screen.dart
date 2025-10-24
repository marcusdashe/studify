
import 'package:flutter/material.dart';
import 'package:studify_flutter_challenge/presentation/screens/quiz_screen.dart';

import '../../core/constants/studify_colors.dart';
import '../widgets/circular_back_button.dart';



class StudyModeOverviewScreen extends StatelessWidget {
  static const routeName = '/study-mode-overview-screen';

  final String quizTitle;

  const StudyModeOverviewScreen({
    super.key,
    required this.quizTitle,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        leading: buildCircularBackButton(context),
        title: const Text(
          'Study mode',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            const Text(
              'Quiz',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF9E9E9E),
              ),
            ),
            const SizedBox(height: 8),

            // Quiz Title (Dynamic)
            Text(
              quizTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 32),

            // --- Quiz Detail Items ---

            // 1. 30 Questions
            _buildDetailItem(
              icon: Icons.question_mark_rounded,
              title: '${QuizData.getSampleQuestions().length} Questions',
              subtitle: 'You will be given ${QuizData.getSampleQuestions().length} questions in quiz',
            ),
            const SizedBox(height: 24),

            // 2. No time limit
            _buildDetailItem(
              icon: Icons.access_time_outlined,
              title: 'No time limit',
              subtitle: 'Self-paced lets you set a high score and break it.',
            ),
            const SizedBox(height: 24),

            // 3. Grading and points
            _buildDetailItem(
              icon: Icons.insights_outlined, // Used a graph icon as a suitable placeholder
              title: 'Grading and points',
              subtitle: '1 pt for quiz completion, 3 pts for a correct answer.',
            ),

            const Spacer(), // Pushes the button to the bottom

            // --- Proceed Button ---
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(QuizScreen.routeName);

                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // Gradient color from your previous button
                    gradient: const LinearGradient(
                      colors: [
                        StudifyColors.primaryLight,
                        StudifyColors.primary,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the individual detail rows
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon (styled to match the design's placeholder icons)
        Icon(
          icon,
          size: 24,
          color: const Color(0xFF9E9E9E), // Light gray/placeholder color
        ),
        const SizedBox(width: 16),
        // Text Content
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
    );
  }
}