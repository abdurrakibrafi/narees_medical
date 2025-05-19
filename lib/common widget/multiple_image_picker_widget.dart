import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

typedef OnFilesChanged = void Function(List<PlatformFile> files);

class MultiFilePicker extends StatefulWidget {
  final OnFilesChanged? onFilesChanged;

  /// Initial files to display (optional)
  final List<PlatformFile>? initialFiles;

  const MultiFilePicker({Key? key, this.onFilesChanged, this.initialFiles}) : super(key: key);

  @override
  State<MultiFilePicker> createState() => _MultiFilePickerState();
}

class _MultiFilePickerState extends State<MultiFilePicker> {
  late List<PlatformFile> selectedFiles;

  @override
  void initState() {
    super.initState();
    selectedFiles = widget.initialFiles ?? [];
  }

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        selectedFiles.addAll(result.files);
      });
      widget.onFilesChanged?.call(selectedFiles);
    }
  }

  void removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
    widget.onFilesChanged?.call(selectedFiles);
  }

  bool isImageFile(String? extension) {
    final ext = extension?.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onPressed: pickFiles,
          icon: const Icon(Icons.upload_file),
          label: const Text('Select Files / Images'),
        ),
        const SizedBox(height: 12),
        if (selectedFiles.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedFiles.length,
              itemBuilder: (context, index) {
                final file = selectedFiles[index];
                if (isImageFile(file.extension)) {
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(File(file.path!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () => removeFile(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          file.extension == 'pdf' ? Icons.picture_as_pdf : Icons.insert_drive_file,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: Text(
                            file.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => removeFile(index),
                          child: const Icon(Icons.close, size: 18, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          )
        else
          const Text('No files selected'),
      ],
    );
  }
}
