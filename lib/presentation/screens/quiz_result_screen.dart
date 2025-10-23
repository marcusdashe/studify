

import 'package:flutter/material.dart';

import '../../core/constants/studify_image_paths.dart';

class QuizResultScreen extends StatelessWidget {
  final int totalScore;
  final int accuracy;
  final String timeTaken;
  final String rank;
  final int totalQuestions;

  const QuizResultScreen({
    super.key,
    required this.totalScore,
    required this.accuracy,
    required this.timeTaken,
    required this.rank,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Background gradient similar to the image
          gradient: LinearGradient(
            colors: [
              Color(0xFFF5F0E8),
              Color(0xFFE8E5F2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Decorative confetti elements
            Positioned(
              top: 10,
              left: 90,
              child: _buildConfetti(Colors.purple.shade200, 12, 12),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: _buildConfetti(Colors.blue.shade300, 10, 10),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: _buildConfetti(Colors.blue.shade300, 10, 10),
            ),
            Positioned(
              top: 30,
              left: 165,
              child: _buildConfetti(Colors.green.shade300, 8, 15),
            ),
            Positioned(
              top: 30,
              right: 165,
              child: _buildConfetti(Colors.green.shade300, 8, 15),
            ),
            Positioned(
              top: 35,
              left: 100,
              child: _buildConfetti(Colors.red.shade200, 8, 8),
            ),
            Positioned(
              top: 35,
              right: 100,
              child: _buildConfetti(Colors.red.shade200, 8, 8),
            ),
            Positioned(
              top: 38,
              left: 145,
              child: _buildConfetti(Colors.orange.shade300, 10, 10),
            ),
            Positioned(
              top: 38,
              right: 145,
              child: _buildConfetti(Colors.orange.shade300, 10, 10),
            ),
            Positioned(
              top: 35,
              left: 220,
              child: _buildConfetti(Colors.orange.shade300, 8, 12),
            ),
            Positioned(
              top: 35,
              right: 220,
              child: _buildConfetti(Colors.orange.shade300, 8, 12),
            ),
            Positioned(
              top: 38,
              left: 120,
              child: _buildConfetti(Colors.orange.shade400, 12, 8),
            ),
            Positioned(
              top: 38,
              right: 120,
              child: _buildConfetti(Colors.orange.shade400, 12, 8),
            ),
            Positioned(
              top: 100,
              left: 260,
              child: _buildConfetti(Colors.orange.shade400, 10, 10),
            ),
            Positioned(
              top: 100,
              right: 260,
              child: _buildConfetti(Colors.orange.shade400, 10, 10),
            ),

            // Decorative wavy lines
            Positioned(
              top: 140,
              left: 20,
              child: _buildWavyLine(Colors.orange.shade300),
            ),
            Positioned(
              top: 140,
              right: 20,
              child: Transform.scale(
                scaleX: -1,
                child: _buildWavyLine(Colors.orange.shade300),
              ),
            ),
            Positioned(
              top: 200,
              left: 30,
              child: _buildWavyLine(Colors.purple.shade300),
            ),
            Positioned(
              top: 200,
              right: 30,
              child: Transform.scale(
                scaleX: -1,
                child: _buildWavyLine(Colors.purple.shade300),
              ),
            ),
            Positioned(
              top: 260,
              left: 25,
              child: _buildWavyLine(Colors.green.shade300),
            ),
            Positioned(
              top: 260,
              right: 25,
              child: Transform.scale(
                scaleX: -1,
                child: _buildWavyLine(Colors.green.shade300),
              ),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Trophy icon - Replace with your asset
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Image.asset(
                      StudifyImagePaths.winner,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback emoji trophy
                        return const Center(
                          child: Text(
                            '🏆',
                            style: TextStyle(fontSize: 80),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // "You crushed it!" text
                  const Text(
                    'You crushed it!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212121),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  const Text(
                    'You\'re getting sharper every quiz.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Points earned
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '+$totalScore',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.diamond,
                        color: Color(0xFF7C3AED),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'earned',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Statistics card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildStatRow(
                            'Total Score',
                            '+$totalScore',
                            icon: Icons.diamond,
                            iconColor: const Color(0xFF7C3AED),
                          ),
                          _buildDivider(),
                          _buildStatRow(
                            'Accuracy',
                            '$accuracy%',
                          ),
                          _buildDivider(),
                          _buildStatRow(
                            'Time Taken',
                            timeTaken,
                          ),
                          _buildDivider(),
                          _buildStatRow(
                            'Rank (Placeholder)',
                            rank,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Bottom buttons
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Retry quiz logic
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF7C3AED),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          ),
                          child: const Text(
                            'Retry quiz',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Return home logic
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF9575CD),
                                    Color(0xFF7C3AED),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Return home',
                                  style: TextStyle(
                                    fontSize: 16,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {IconData? icon, Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 18, color: iconColor),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Divider(height: 1, color: Color(0xFFF5F5F5), thickness: 1),
    );
  }

  Widget _buildConfetti(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildWavyLine(Color color) {
    return CustomPaint(
      size: const Size(40, 60),
      painter: WavyLinePainter(color: color),
    );
  }
}

class WavyLinePainter extends CustomPainter {
  final Color color;

  WavyLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, 0);

    // Create a wavy line
    path.quadraticBezierTo(10, 15, 0, 30);
    path.quadraticBezierTo(-10, 45, 0, 60);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

