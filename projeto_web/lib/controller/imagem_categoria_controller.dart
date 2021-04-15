import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoriaController extends GetxController {
  File image;

  var selectedImagePath = ''.obs;

  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      print("No image selected.");
    }
  }
}
