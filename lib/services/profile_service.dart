import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';

class ProfileService {
  Future<UserModel> getUserProfile() async {
    var respJson = await ApiService().post('/user/profile', contentType: false);
    UserModel userProfile = UserModel.fromJson({});
    if (respJson['status']) {
      var respData = respJson['data'];
      userProfile = UserModel.fromJson(respData);
    }

    return userProfile;
  }

  updateUserImg(filePath) async {
    String imgUploaded = '';
    var resJson = await UploadsService().uploadSingleImage(filePath);
    if (resJson['status']) {
      imgUploaded = resJson['data']['path'];
    }
    return imgUploaded;
  }

  updateUserProfile(context, UserModel user, filePath) async {
    String imgToLoad = '';
    String imgOrg = '';
    if (filePath.isNotEmpty) {
      imgToLoad = await updateUserImg(filePath);
    } else if (user.imgURL!.isNotEmpty) {
      imgOrg = user.imgURL!;
    }
    var userJson = user.toJson();
    Map<String, dynamic> update = {
      'name': userJson['name'],
      'email': userJson['email'],
      'mobile': userJson['mobile'],
      'imgURL': imgToLoad.isEmpty ? imgOrg : imgToLoad,
    };
    var resJson = await ApiService().patch('/user/', update);
    if (resJson['status'] == true) {
      List<AdModel> userAds = await AdService().getMyAds();
      for (AdModel userAd in userAds) {
        await AdService().updateAd(userAd, [], userAd.id.toString(), context);
      }
      await getUserProfile();
      return true;
    }
    return false;
  }
}
