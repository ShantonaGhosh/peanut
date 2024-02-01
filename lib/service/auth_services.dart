import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peanut/common/variables.dart';

import '../common/app_color.dart';
import '../common/const.dart';

import '../widget/custom_snackbar.dart';

class AuthServices extends GetConnect {
  static var isLoading = false.obs;
  GetStorage userData = GetStorage();

  Future<void> login({String? userId, String? userPass}) async {
    try {
      isLoading(true);
      String url =
          '${base_url}api/ClientCabinetBasic/IsAccountCredentialsCorrect';

      final http.Response  response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"login": userId, "password": userPass}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String token = jsonResponse['token'];
        await userData.write('userId', userId ?? '');

        await userData.write('userPass', userPass ?? '');
        await userData.write('token', token);

        loginUserId =  userData.read("userId");
        loginUserPass =  userData.read("userPass");
        loginToken =  userData.read("token");

        Get.offAllNamed("/route");
      } else {
        customSnackBar(bgClr: snackBarErrorClr, msg: 'Somethings wants wrong');
      }
    } finally {
      isLoading(false);
    }
  }

  Future isUserLogin() async {
    loginUserId = userData.read("userId") ?? '';
    loginUserPass = userData.read("userPass") ?? '';
    loginToken = userData.read("token");

    if (loginUserId!.isNotEmpty && loginUserPass!.isNotEmpty) {
      Get.offNamed('/route');
    } else {
      Get.offNamed('/login');
    }
  }

  Future<void> logOut() async {
    await userData.erase();
    customSnackBar(bgClr: snackBarSuccessClr, msg: 'LogOut Successful');

    Get.offAllNamed("/login");
  }
}
