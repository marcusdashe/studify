

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:docx_to_text/docx_to_text.dart';

import '../../core/constants/studify_colors.dart';
import '../../data/models/file_model.dart';
import '../../env/env_config.dart';
import '../widgets/quiz_selection_dialog.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

class FileSummaryScreen extends StatefulWidget {
  final FileModel file;
  const FileSummaryScreen({super.key, required this.file});

  @override
  State<FileSummaryScreen> createState() => _FileSummaryScreenState();
}

class _FileSummaryScreenState extends State<FileSummaryScreen> {
  String _summaryText = "Generating summary...";
  bool _isLoading = true;
  String _errorText = "";

  @override
  void initState() {
    super.initState();
    final extension = widget.file.fileExtension.toLowerCase();

    // Only generate summary for supported document types
    if (['pdf', 'docx', 'txt', 'doc'].contains(extension)) {
      _generateSummary();
    } else {
      // For images or unsupported types
      setState(() {
        _isLoading = false;
        _summaryText = ['png', 'jpeg', 'jpg'].contains(extension)
            ? "" // Empty for images since they'll be displayed
            : "Unsupported file type for summary generation.";
      });
    }
  }

  // Extract text based on file type
  Future<String> _extractTextFromFile() async {
    final file = File(widget.file.filePath);
    if (!file.existsSync()) {
      throw Exception("File not found at path: ${widget.file.filePath}");
    }

    final extension = widget.file.fileExtension.toLowerCase();

    try {
      switch (extension) {
        case 'pdf':
          return await _extractFromPdf(file);
        case 'docx':
        case 'doc':
          return await _extractFromDocx(file);
        case 'txt':
          return await _extractFromTxt(file);
        default:
          throw Exception("Unsupported file format: $extension");
      }
    } catch (e) {
      debugPrint("Error extracting text: $e");
      rethrow;
    }
  }

  // Extract text from PDF using Syncfusion
  Future<String> _extractFromPdf(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final document = PdfDocument(inputBytes: bytes);
      final textExtractor = PdfTextExtractor(document);
      final text = textExtractor.extractText();
      document.dispose();
      return text;
    } catch (e) {
      throw Exception("Failed to extract PDF text: $e");
    }
  }

  // Extract text from DOCX using docx_to_text
  Future<String> _extractFromDocx(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final text = docxToText(bytes);
      if (text == null || text.isEmpty) {
        throw Exception("No text content found in document");
      }
      return text;
    } catch (e) {
      throw Exception("Failed to extract DOCX text: $e");
    }
  }

  // Extract text from TXT file
  Future<String> _extractFromTxt(File file) async {
    try {
      return await file.readAsString();
    } catch (e) {
      throw Exception("Failed to read TXT file: $e");
    }
  }

  // Generate AI summary using Gemini
  Future<void> _generateSummary() async {
    setState(() {
      _isLoading = true;
      _errorText = "";
    });

    try {
      // Extract text from the file
      final rawText = await _extractTextFromFile();

      if (rawText.trim().isEmpty) {
        throw Exception("Could not extract any readable text from the file.");
      }

      debugPrint("Extracted text length: ${rawText.length} characters");

      // Limit the text sent to Gemini to prevent hitting token limits
      // Using 50000 characters (~12500 tokens) as a safe limit
      final textToSummarize = rawText.length > 50000
          ? rawText.substring(0, 50000)
          : rawText;

      // Create prompt for Gemini
      final prompt = '''
Generate a concise and informative summary of the following document content.

File name: ${widget.file.fileName}

Instructions:
- Create a clear, well-structured summary
- Highlight the main points and key information
- Keep it concise but comprehensive (around 200-300 words)
- Use proper paragraphs for readability

Document content:

$textToSummarize
''';

      // Call Gemini API
      final response = await EnvConfig.model.generateContent(
        [Content.text(prompt)],
      );

      if (mounted) {
        setState(() {
          _summaryText = response.text ?? "Summary generation failed: empty response.";
          _isLoading = false;
        });
      }

    } catch (e) {
      debugPrint("Summary generation error: $e");

      if (mounted) {
        setState(() {
          _errorText = "Error: Could not generate summary. ${e.toString().contains('API') ? 'Please check your API key.' : 'Please check file format and permissions.'}";
          _summaryText = "";
          _isLoading = false;
        });
      }
    }
  }

  // Helper function to build the content
  Widget _buildContent() {
    final extension = widget.file.fileExtension.toLowerCase();
    final isImage = ['png', 'jpeg', 'jpg'].contains(extension);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section (for all file types)
        const Text(
          'Summary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF9E9E9E)),
        ),
        const SizedBox(height: 4),
        Text(
          widget.file.fileName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF212121)),
        ),
        const SizedBox(height: 4),
        Text(
          widget.file.date,
          style: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        ),
        const SizedBox(height: 20),

        // Content Section
        if (isImage)
        // Image viewer
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: () {
                final imageFile = File(widget.file.filePath);
                return imageFile.existsSync()
                    ? Image.file(imageFile, fit: BoxFit.contain)
                    : const Text('Error: Image file not found or inaccessible.');
              }(),
            ),
          )
        else
        // Document summary
          if (_isLoading)
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Analyzing document...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            )
          else if (_errorText.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _generateSummary,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: TextButton.styleFrom(
                    foregroundColor: StudifyColors.primary,
                  ),
                ),
              ],
            )
          else
            Text(
              _summaryText,
              style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF424242)),
            ),
      ],
    );
  }

  void _showQuizSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const QuizSelectionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF212121)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF212121)),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!['png', 'jpeg', 'jpg'].contains(widget.file.fileExtension.toLowerCase()))
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      Icon(Icons.menu_book, size: 28, color: Color(0xFF9E9E9E)),
                      SizedBox(height: 20),
                    ],
                  ),
                _buildContent(),
              ],
            ),
          ),
          // Sticky "Start quiz" Button at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  _showQuizSelectionDialog(context);
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.diamond, size: 20, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Start quiz',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class FileSummaryScreen extends StatefulWidget {
//   final FileModel file;
//   const FileSummaryScreen({super.key, required this.file});
//
//   @override
//   State<FileSummaryScreen> createState() => _FileSummaryScreenState();
// }
//
// class _FileSummaryScreenState extends State<FileSummaryScreen> {
//   String _summaryText = "Extracting content...";
//   bool _isLoading = true;
//   String _errorText = "";
//
//   @override
//   void initState() {
//     super.initState();
//     final extension = widget.file.fileExtension.toLowerCase();
//
//     // Only extract text for supported document types
//     if (['pdf', 'docx', 'txt', 'doc'].contains(extension)) {
//       _extractDocumentPreview();
//     } else {
//       // For images or unsupported types
//       setState(() {
//         _isLoading = false;
//         _summaryText = ['png', 'jpeg', 'jpg'].contains(extension)
//             ? "" // Empty for images since they'll be displayed
//             : "Unsupported file type for text extraction.";
//       });
//     }
//   }
//
//   // Extract text based on file type
//   Future<String> _extractTextFromFile() async {
//     final file = File(widget.file.filePath);
//     if (!file.existsSync()) {
//       throw Exception("File not found at path: ${widget.file.filePath}");
//     }
//
//     final extension = widget.file.fileExtension.toLowerCase();
//
//     try {
//       switch (extension) {
//         case 'pdf':
//           return await _extractFromPdf(file);
//         case 'docx':
//         case 'doc':
//           return await _extractFromDocx(file);
//         case 'txt':
//           return await _extractFromTxt(file);
//         default:
//           throw Exception("Unsupported file format: $extension");
//       }
//     } catch (e) {
//       debugPrint("Error extracting text: $e");
//       rethrow;
//     }
//   }
//
//   // Extract text from PDF using Syncfusion
//   Future<String> _extractFromPdf(File file) async {
//     try {
//       final bytes = await file.readAsBytes();
//       final document = PdfDocument(inputBytes: bytes);
//       final textExtractor = PdfTextExtractor(document);
//       final text = textExtractor.extractText();
//       document.dispose();
//       return text;
//     } catch (e) {
//       throw Exception("Failed to extract PDF text: $e");
//     }
//   }
//
//   // Extract text from DOCX using docx_to_text
//   Future<String> _extractFromDocx(File file) async {
//     try {
//       final bytes = await file.readAsBytes();
//       final text = docxToText(bytes);
//       if (text == null || text.isEmpty) {
//         throw Exception("No text content found in document");
//       }
//       return text;
//     } catch (e) {
//       throw Exception("Failed to extract DOCX text: $e");
//     }
//   }
//
//   // Extract text from TXT file
//   Future<String> _extractFromTxt(File file) async {
//     try {
//       return await file.readAsString();
//     } catch (e) {
//       throw Exception("Failed to read TXT file: $e");
//     }
//   }
//
//   // Extract a preview/snippet from the document
//   Future<void> _extractDocumentPreview() async {
//     setState(() {
//       _isLoading = true;
//       _errorText = "";
//     });
//
//     try {
//       final rawText = await _extractTextFromFile();
//
//       if (rawText.trim().isEmpty) {
//         throw Exception("Could not extract any readable text from the file.");
//       }
//
//       // Extract first portion of text as preview
//       // Remove excessive whitespace and newlines
//       final cleanedText = rawText
//           .replaceAll(RegExp(r'\s+'), ' ')
//           .trim();
//
//       // Get first 500 characters or until the end of a sentence near that point
//       String preview;
//       if (cleanedText.length <= 500) {
//         preview = cleanedText;
//       } else {
//         // Try to cut at a sentence boundary (period, exclamation, or question mark)
//         final cutPoint = cleanedText.substring(0, 500);
//         final lastSentenceEnd = cutPoint.lastIndexOfAny(['. ', '! ', '? ']);
//
//         if (lastSentenceEnd > 200) {
//           // If we found a good sentence break after 200 chars, use it
//           preview = cleanedText.substring(0, lastSentenceEnd + 1);
//         } else {
//           // Otherwise, cut at 500 chars and add ellipsis at word boundary
//           final lastSpace = cutPoint.lastIndexOf(' ');
//           preview = cleanedText.substring(0, lastSpace > 400 ? lastSpace : 500) + '...';
//         }
//       }
//
//       if (mounted) {
//         setState(() {
//           _summaryText = preview;
//           _isLoading = false;
//         });
//       }
//
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _errorText = "Error: Could not extract text. ${e.toString().contains('Failed') ? 'Please check file format.' : 'Check file permissions.'}";
//           _summaryText = "";
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   // Helper function to build the content
//   Widget _buildContent() {
//     final extension = widget.file.fileExtension.toLowerCase();
//     final isImage = ['png', 'jpeg', 'jpg'].contains(extension);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header Section (for all file types)
//         const Text(
//           'Summary',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF9E9E9E)),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           widget.file.fileName,
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF212121)),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           widget.file.date,
//           style: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
//         ),
//         const SizedBox(height: 20),
//
//         // Content Section
//         if (isImage)
//         // Image viewer
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: () {
//                 final imageFile = File(widget.file.filePath);
//                 return imageFile.existsSync()
//                     ? Image.file(imageFile, fit: BoxFit.contain)
//                     : const Text('Error: Image file not found or inaccessible.');
//               }(),
//             ),
//           )
//         else
//         // Document preview
//           if (_isLoading)
//             const Center(child: CircularProgressIndicator())
//           else if (_errorText.isNotEmpty)
//             Text(_errorText, style: const TextStyle(color: Colors.red))
//           else
//             Text(
//               _summaryText,
//               style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF424242)),
//             ),
//       ],
//     );
//   }
//
//   void _showQuizSelectionDialog(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return const QuizSelectionDialog();
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white.withOpacity(0.9),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF212121)),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text('Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF212121))),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (!['png', 'jpeg', 'jpg'].contains(widget.file.fileExtension.toLowerCase()))
//                   const Column(
//                     children: [
//                       SizedBox(height: 20),
//                       Icon(Icons.menu_book, size: 28, color: Color(0xFF9E9E9E)),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 _buildContent(),
//               ],
//             ),
//           ),
//           // Sticky "Start quiz" Button at the bottom
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: GestureDetector(
//                 onTap: () {
//                   _showQuizSelectionDialog(context);
//                 },
//                 child: Container(
//                   height: 56,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     gradient: const LinearGradient(
//                       colors: [
//                         StudifyColors.primaryLight,
//                         StudifyColors.primary,
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: const Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.diamond, size: 20, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text('Start quiz', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Extension helper for finding multiple characters
// extension StringExtensions on String {
//   int lastIndexOfAny(List<String> patterns) {
//     int maxIndex = -1;
//     for (final pattern in patterns) {
//       final index = lastIndexOf(pattern);
//       if (index > maxIndex) {
//         maxIndex = index;
//       }
//     }
//     return maxIndex;
//   }


