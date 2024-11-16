import 'package:get/get.dart';
import 'package:taskmanager/data/model/login_model.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/service/network_caller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  String? get erroMessage => _errorMessage;

  bool get inProgress => _inProgress;

  Future<bool> SignIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(Url: urls.login, body: requestBody);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await AuthController.saveAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.data!);
      isSuccess = true;
    }
    else {
      _errorMessage = response.erroMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}