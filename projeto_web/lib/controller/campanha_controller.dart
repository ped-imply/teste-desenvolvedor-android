import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CampanhaController extends GetxController {
  File image1;
  File image2;
  File image3;
  File image4;
  var selectedImagePath1 = ''.obs;
  var selectedImagePath2 = ''.obs;
  var selectedImagePath3 = ''.obs;
  var selectedImagePath4 = ''.obs;

  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();
  final picker4 = ImagePicker();

  void getImage1() async {
    final pickedFile1 = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile1 != null) {
      selectedImagePath1.value = pickedFile1.path;
    } else {
      print("No image selected");
    }
  }

  void getImage2() async {
    final pickedFile2 = await picker2.getImage(source: ImageSource.gallery);

    if (pickedFile2 != null) {
      selectedImagePath2.value = pickedFile2.path;
    } else {
      print("No image selected");
    }
  }

  void getImage3() async {
    final pickedFile3 = await picker3.getImage(source: ImageSource.gallery);

    if (pickedFile3 != null) {
      selectedImagePath3.value = pickedFile3.path;
    } else {
      print("No image selected");
    }
  }

  void getImage4() async {
    final pickedFile4 = await picker3.getImage(source: ImageSource.gallery);

    if (pickedFile4 != null) {
      selectedImagePath4.value = pickedFile4.path;
    } else {
      print("No image selected");
    }
  }

  void clearImages() {
    selectedImagePath1.value = null;
    selectedImagePath2.value = null;
    selectedImagePath3.value = null;
    selectedImagePath4.value = null;
  }
}
