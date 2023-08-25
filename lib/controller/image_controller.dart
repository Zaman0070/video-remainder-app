import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reminder_app/constant/widget/loading.dart';
import 'package:video_compress/video_compress.dart';

class ImagePickerController extends GetxController {
  PickedFile? pickedFile;
  List<File> selectedImages = <File>[].obs;
  List<String> images = <String>[].obs;
  var downloadURL = ''.obs;

  ///// Video ///

  var selectPathVideo = File('').obs;

  //
  PickedFile? pickedVideo;
  Rx<File> selectedVideo = File('').obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var videoUrl = ''.obs;
  String videoThumbnailUrl = '';

  Future<List<String>> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickImage(source: source);

    if (pickedFiles != null) {
      pickedFile = PickedFile(pickedFiles.path);
      update();
      selectedImages = [File(pickedFiles.path)];
      update();
    }
    return uploadImagesToFirebase(selectedImages);
  }

  Future<List<String>> pickMulti() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.assignAll(
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
    }
    if (selectedImages.isEmpty) {
      return [];
    }
    return uploadImagesToFirebase(selectedImages);
  }

  Future<List<String>> uploadImagesToFirebase(List selectedImages) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'Loading ...',
        );
      },
    );
    final storage = FirebaseStorage.instance;
    List<String> listImages = <String>[].obs;
    for (var image in selectedImages) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$fileName');
      final uploadTask = reference.putFile(image);

      final snapshot =
          await uploadTask.whenComplete(() => print('Image uploaded'));
      final imageUrl = await snapshot.ref.getDownloadURL();
      listImages.add(imageUrl);
      update();
    }
    SmartDialog.dismiss();
    return listImages;
  }

  Future<void> uploadAssetImages(List<String> assetPaths) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'Loading ...',
        );
      },
    );
    for (String assetPath in assetPaths) {
      // Read the asset image as bytes
      ByteData byteData = await rootBundle.load(assetPath);

      // Create a reference to the location in Firebase Storage where you want to store the image
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
      UploadTask uploadTask =
          storageReference.putData(byteData.buffer.asUint8List());
      await uploadTask.whenComplete(() async {
        downloadURL.value = await storageReference.getDownloadURL();
        SmartDialog.dismiss();
      });
    }
  }

  ///// video /////
  ///
  getThumbnail(File videoPath) async {
    final getthumbnail = await VideoCompress.getFileThumbnail(videoPath.path);
    return getthumbnail;
  }

  Future<String> pickVideo(ImageSource imageSource) async {
    final videPicker = ImagePicker();
    final pickedVideoes = await videPicker.pickVideo(source: imageSource);
    if (pickedVideoes != null) {
      pickedVideo = PickedFile(pickedVideoes.path);
      selectedVideo.value = File(pickedVideoes.path);
      update();
    }
    return uploadVideo(selectedVideo.value);
  }

  Future<String> uploadVideo(File videoFile) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: 'Please wait...',
        );
      },
    );
    String fileName = '${DateTime.now()}.mp4';
    Reference reference = _storage.ref().child('videos/$fileName');
    UploadTask uploadTask = reference.putFile(videoFile);
    await uploadTask.whenComplete(() => print('Video uploaded successfully'));
    videoUrl.value = await reference.getDownloadURL();
    String fileNames = '${DateTime.now()}.jpg';
    Reference references = _storage.ref().child('thumbnail/$fileNames');
    var thumbnail = await references.putFile(await getThumbnail(videoFile));
    videoThumbnailUrl = await thumbnail.ref.getDownloadURL();
    update();
    SmartDialog.dismiss();
    return videoUrl.value;
  }
}
