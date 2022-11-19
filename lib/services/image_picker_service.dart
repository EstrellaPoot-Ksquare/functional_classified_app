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
      print(file.path.runtimeType);
      return file.path.toString();
    }
    print(file);

    return '';
  }

  Future<List<String>> loadMultipleImagesFromDevice() async {
    List<String> files = [];
    var xFiles = await ImagePicker().pickMultiImage();

    if (xFiles.isNotEmpty) {
      print(xFiles.runtimeType);
      files = xFiles.map<String>((xFile) => xFile.path.toString()).toList();
      print(files);

      return files;
    }
    print(files);

    return [];
  }
}
