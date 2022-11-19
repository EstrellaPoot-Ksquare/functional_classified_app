import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';

class AdService {
// https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png
  Future<List<AdModel>> getAllAds() async {
    List<AdModel> ads = [];
    var respJson = await ApiService().get('/ads');
    print('getAds: $respJson');
    if (respJson['status']) {
      var adsData = respJson['data'];
      ads = adsData.map<AdModel>((ad) => AdModel.fromJson(ad)).toList();
    }

    return ads;
  }

  Future<List<AdModel>> getMyAds() async {
    List<AdModel> myAds = [];
    var resJson = await ApiService().post('/ads/user', contentType: false);
    print('myADs: $resJson');
    if (resJson['status']) {
      var adsData = resJson['data'];
      myAds = adsData.map<AdModel>((ad) => AdModel.fromJson(ad)).toList();
    }

    return myAds;
  }

  Future createAd(AdModel ad, List<String> newImages, context) async {
    AdModel newAd = AdModel();
    var adJson = ad.toJson();
    var images = adJson['images'];
    print('images: ${images.length}');
    List<String> uploadedImages = [];
    if (newImages.isNotEmpty) {
      uploadedImages = await uploadAdImages(newImages);
    } else {
      uploadedImages = images;
    }

    print('complete ad: ${ad.toJson()}');
    Map<String, dynamic> createAd = {
      'title': adJson['title'],
      'description': adJson['description'],
      'price': adJson['price'],
      'mobile': adJson['mobile'],
      'images': uploadedImages,
    };
    print(createAd);
    var resJson = await ApiService().post('/ads', body: createAd);
    print('AdresJson: $resJson');
    if (resJson['status']) {
      var adData = resJson['data'];
      newAd = AdModel.fromJson(adData);
      // Navigator.pop(context);
      // AlertManager().displaySnackbar(context, 'Ad Created');
      return true;
    }
    print('ad updated: ${newAd.toJson()}');
    return false;
    // return newAd;
  }

  Future<List<String>> uploadAdImages(List<String> images) async {
    List<String> uploadedImages = [];
    var resJson = await UploadsService().uploadMultipleImages(images);
    print('load image response: $resJson');
    if (resJson['status']) {
      var uploadedImgPaths = resJson['data']['path'];
      print('typeResponseImages: ${resJson['data']['path'].runtimeType}');
      uploadedImages = uploadedImgPaths
          .map<String>((imgPath) => imgPath.toString())
          .toList();
    }
    print('image uploaded: $uploadedImages');
    return uploadedImages;
  }

  Future updateAd(
      AdModel ad, List<String> newImages, String id, context) async {
    AdModel updatedAd = AdModel();
    var adJson = ad.toJson();
    var images = adJson['images'];

    List<String> uploadedImages = [];
    if (newImages.isNotEmpty) {
      uploadedImages = await uploadAdImages(newImages);
    } else {
      uploadedImages = images;
    }

    UserModel user = await ProfileService().getUserProfile();

    Map<String, dynamic> updatingAd = {
      'title': adJson['title'],
      'description': adJson['description'],
      'price': adJson['price'],
      'mobile': adJson['mobile'],
      'authorName': user.name,

      // 'images': ['https://placehold.jp/150x150.png'],
      'images': uploadedImages,
    };
    var resJson = await ApiService().patch('/ads/$id', updatingAd);
    if (resJson['status']) {
      var adData = resJson['data'];
      updatedAd = AdModel.fromJson(adData);
      return true;
    }
    return false;
  }

  Future<bool> deleteAd(String id) async {
    bool deleted = false;
    var resJson = await ApiService().delete('/ads/$id');
    if (resJson['status']) {
      var adDeleted = resJson['data'];
      deleted = true;
    }
    return deleted;
  }
}
