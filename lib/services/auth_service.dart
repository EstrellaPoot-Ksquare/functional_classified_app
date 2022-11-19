import 'package:classified_app/models/models.dart';
import 'package:classified_app/services/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future register(UserModel user) async {
    var respJson =
        await ApiService().post('/auth/register', body: user.toJson());
    print(respJson);
    if (respJson['status']) {
      return true;
    }
    return false;
  }

// ? my userId = 636db6d73f6cd6d0995352b7
// ? my name = estrella
// ? my email = estrella@gmail.com
// ? my password = 123456
// ? my mobile = 9994867654
// ? profileImg = ''
  Future login(context, UserModel user, String redirectRoute) async {
    var respJson = await ApiService().post('/auth/login', body: user.toJson());

    if (respJson['status'] == false) {
      return false;
    } else {
      // print(respJson['data']);
      var respData = respJson['data'];
      // print('userid: ${respData['user']['_id']}');
      // print('token: ${respData['token']}');

      storage.write(key: 'userId', value: respData['user']['_id']);
      storage.write(key: 'token', value: respData['token']);
      UserModel user = UserModel.fromJson(respJson['data']);
      print(user);
      return UserModel.fromJson(respData);
    }
  }
}
