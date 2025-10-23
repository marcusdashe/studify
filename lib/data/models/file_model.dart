
class FileModel {
  final String fileName;
  final String date;
  final String iconPath;
  final String filePath;
  final String fileExtension; // e.g., 'pdf', 'docx'

  FileModel({
    required this.fileName,
    required this.date,
    required this.iconPath,
    required this.filePath,
    required this.fileExtension,
  });
}