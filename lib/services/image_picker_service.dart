import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImageSource _getImageSource(String source) {
    switch (source) {
      case 'camera':
        return ImageSource.camera;
      case 'gallery':
        return ImageSource.gallery;
      default:
        return ImageSource.camera;
    }
  }

  Future<String> loadImageFromDevice({required String source}) async {
    var file = await ImagePicker().pickImage(source: _getImageSource(source));
    if (file != null) {
      return file.path.toString();
    }
    return '';
  }

  Future<List<String>> loadMultipleImagesFromDevice() async {
    List<String> files = [];
    var xFiles = await ImagePicker().pickMultiImage();
    if (xFiles.isNotEmpty) {
      files = xFiles.map<String>((xFile) => xFile.path.toString()).toList();
      return files;
    }
    return [];
  }
}
