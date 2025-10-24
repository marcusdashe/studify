import 'package:flutter/material.dart';
import '../../core/constants/studify_image_paths.dart';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../data/models/file_model.dart';
import '../widgets/file_item_widget.dart';
import 'ai_content_processing_screen.dart';
import 'file_summary_screen.dart';



class FileManagementScreen extends StatefulWidget {
  static const routeName = '/file-management-screen';
  const FileManagementScreen({super.key});
  @override
  State<FileManagementScreen> createState() => _FileManagementScreenState();
}

class _FileManagementScreenState extends State<FileManagementScreen> {
  final List<FileModel> _recentFiles = [];

  void _onFileTapped(FileModel file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FileSummaryScreen(file: file),
      ),
    );
  }

  // 2. Function to handle file picking and navigation
  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = result.files.single;
      final filePath = pickedFile.path!;
      final fileName = pickedFile.name;
      final now = DateTime.now();

      // Get the file extension to decide the icon
      final extension = fileName.split('.').last.toLowerCase();
      String iconPath = StudifyImagePaths.note; // Default icon
      if (extension == 'pdf') {
        iconPath = StudifyImagePaths.note;
      } else if (extension.contains('doc')) {
        iconPath = StudifyImagePaths.note;
      } else if (extension.contains('docx')) {
        iconPath = StudifyImagePaths.note;
      } else if (extension.contains('ppt')) {
        iconPath = StudifyImagePaths.note;
      } else if (extension.contains('pptx')) {
        iconPath = StudifyImagePaths.note;
      } else if (extension.contains('txt')) {
        iconPath = StudifyImagePaths.note;
      }

      final newFile = FileModel(
        fileName: fileName,
        date: DateFormat('MMM d, yyyy').format(now),
        iconPath: iconPath,
        filePath: filePath,
        fileExtension: extension,

      );

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UploadProgressScreen(file: newFile),
        ),
      );

      setState(() {
        _recentFiles.insert(0, newFile);
      });

    } else {
      // User canceled the picker
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            //Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Image.asset(
                        StudifyImagePaths.avatar,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Greeting and Rank
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              StudifyImagePaths.trophy,
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Rank: 12th',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Hello, Okechukwu O.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Points Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '138',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          StudifyImagePaths.diamond,
                          width: 16,
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Your recents Section
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Text(
                        'Your recents',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _recentFiles.length,
                        itemBuilder: (context, index) {
                          final file = _recentFiles[index];
                          return FileItem(
                            file: file, // Pass the entire model
                            onTap: () => _onFileTapped(file), // Pass the callback
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                      ),
                    ),

                    // Upload Button: Tap handler updated
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                          child: GestureDetector(
                            onTap: _pickAndUploadFile, // CALL THE NEW FUNCTION
                            child: Container(
                              height: 50, // Adjust height as needed
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                // Apply the gradient
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF9284E1), // primaryLight
                                    Color(0xFF5B3FFF), // primary
                                  ],
                                  // Default (top to bottom)
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF5B3FFF).withOpacity(0.4), // Use darker color for shadow
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min, // To keep the container size tight to content
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8), // Spacing between icon and text
                                  Text(
                                    'Upload new file',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
