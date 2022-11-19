import 'package:classified_app/services/services.dart';

class UploadsService {
  uploadSingleImage(filePath) async {
    var respJson = await ApiService().multipartRequest(
      '/upload/profile',
      'POST',
      'avatar',
      filePath: filePath,
    );
    return respJson;
  }

  uploadMultipleImages(List<String> imageList) async {
    var respJson = await ApiService().multipartRequest(
        '/upload/photos', 'POST', 'photos',
        imageList: imageList);
    return respJson;
  }
}
