import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image; // To store the selected/taken image
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the UI with the selected image
      });
    }
  }

  // Function to take picture with camera
  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path); // Update the UI with the captured image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image if it exists, otherwise show a placeholder
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    _image!,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            // Button to pick from gallery
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 10),
            // Button to take picture with camera
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              child: const Text('Take Picture with Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
