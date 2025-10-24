
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../core/constants/studify_image_paths.dart';
import '../../data/models/file_model.dart';


class UploadProgressScreen extends StatefulWidget {
  final FileModel file; // To potentially show file details or use its icon
  const UploadProgressScreen({super.key, required this.file});

  @override
  State<UploadProgressScreen> createState() => _UploadProgressScreenState();
}

class _UploadProgressScreenState extends State<UploadProgressScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isScanComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Duration for the progress animation
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Update the UI as the animation progresses
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Call the updated completion function
          _uploadComplete();
        }
      });

    _controller.forward(); // Start the animation
  }

  void _uploadComplete() {
    // 1. Update the state to show 'Scan complete!'
    setState(() {
      _isScanComplete = true;
    });

    // 2. Wait a moment (e.g., 2 seconds) before navigating back
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use this to determine the text based on the completion status
    final String statusText = _isScanComplete ? 'Scan complete!' : 'Analyzing ...';

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              StudifyImagePaths.bgAIPSPath,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circular File Icon Container
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      widget.file.iconPath,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Scanning your document...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 24),
                // Progress Bar and Status Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 1.0,
                      animation: false,
                      lineHeight: 8.0,
                      percent: _animation.value,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: const Color(0xFF7E57C2),
                      barRadius: const Radius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      statusText, // Use the dynamically updated status text
                      style: TextStyle(
                        fontSize: 14,
                        // Change color to green on completion for better visual feedback
                        color: _isScanComplete ? Colors.green.shade700 : const Color(0xFF757575),
                        fontWeight: _isScanComplete ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}