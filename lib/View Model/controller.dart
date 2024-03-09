import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:yuut_admin/Const/media.dart';

class Controller with ChangeNotifier {
  // late VideoPlayerController videoPlayerController;

  // Future initializeController() async {
  //   videoPlayerController = VideoPlayerController.asset(homeVideoasset,
  //       videoPlayerOptions: VideoPlayerOptions())
  //     ..initialize().then((value) {
  //       videoPlayerController.setLooping(true);
  //       videoPlayerController.play();

  //       videoPlayerController.setVolume(0);
  //     });
  // }

  // disposeController() {
  //   videoPlayerController.dispose();
  // }

  //----------------------------pick image--------------------------
  final imagePicker = ImagePicker();

  ///---------------gallery
  List<File> imageList = [];
  Future<List<File>> pickImagesFormGallery() async {
    await imagePicker.pickMultiImage().then((listX) {
      imageList = listX.map((e) {
        return File(e.path);
      }).toList();
    });
    notifyListeners();
    return imageList;
  }

  //---------------camera

  Future<List<File>> pickImageFromCamera() async {
    await imagePicker.pickImage(source: ImageSource.camera).then((xFile) {
      imageList.add(File(xFile!.path));
    });
    notifyListeners();
    return imageList;
  }

  dispiseImage() {
    imageList = [];
    notifyListeners();
  }
}
