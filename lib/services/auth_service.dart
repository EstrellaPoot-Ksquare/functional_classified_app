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

  Future login(context, UserModel user, String redirectRoute) async {
    var respJson = await ApiService().post('/auth/login', body: user.toJson());
    if (respJson['status'] == false) {
      return false;
    } else {
      var respData = respJson['data'];
      storage.write(key: 'userId', value: respData['user']['_id']);
      storage.write(key: 'token', value: respData['token']);
      return UserModel.fromJson(respData);
    }
  }
}
