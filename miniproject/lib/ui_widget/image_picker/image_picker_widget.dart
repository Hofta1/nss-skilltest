import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {

  const ImagePickerWidget({super.key, required this.title});
  final String title;

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState(title);
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? imagePicked; // Variable to store the selected image file
  String title;

  ImagePickerWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          Text(title),
          if (imagePicked != null)
            Image.asset( imagePicked!.path, width: 100, height: 100)
          else
            Text('No image selected.'),
        ElevatedButton(
          onPressed: () {
            pickImageFromGallery().then((image) {
              if (image != null) {
                setState(() {
                  imagePicked = image; // Store the selected image file
                });
                // Handle the selected image here
                print('Selected image path: ${image.path}');
              }
            });
          },
          child: Text('Pick Image'),
        ),
        // Display the picked image here
      ],
  );
}
}

class ImageMultiplePickerWidget extends StatefulWidget {
  const ImageMultiplePickerWidget({super.key, required this.title});
  final String title;

  @override
  ImageMultiplePickerWidgetState createState() => ImageMultiplePickerWidgetState(title);
}

class ImageMultiplePickerWidgetState extends State<ImageMultiplePickerWidget> {
  List<XFile>? imagesPicked; // Variable to store the selected image files
  String title;

  ImageMultiplePickerWidgetState(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        if (imagesPicked != null && imagesPicked!.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: imagesPicked!.map((image) {
              return Image.file(File(image.path), width: 100, height: 100);
            }).toList(),
          )
        else
          Text('No images selected.'),
        ElevatedButton(
          onPressed: () {
            pickMultipleImagesFromGallery().then((images) {
              if (images != null && images.isNotEmpty) {
                setState(() {
                  imagesPicked = images; // Store the selected image files
                });
                // Handle the selected images here
                print('Selected image paths: ${images.map((image) => image.path).join(', ')}');
              }
            });
          },
          child: Text('Pick Multiple Images'),
        ),
      ],
    );
  }
}

Future<XFile?> pickImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<List<XFile>?> pickMultipleImagesFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  List<XFile>? images = await imagePicker.pickMultiImage();
  return images;
}