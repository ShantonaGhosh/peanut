import 'dart:convert';

import 'package:get/get.dart';

import 'package:peanut/common/const.dart';
import 'package:peanut/common/variables.dart';
import 'package:peanut/model/account_info_model.dart';
import 'package:http/http.dart' as http;

import '../common/app_color.dart';
import '../widget/custom_snackbar.dart';

class AccountInfoService extends GetConnect {
  static var isLoading = false.obs;

  Future<AccountInfoModel?> getAccountInfo() async {
    try {
      isLoading(true);
      String accountInfoUrl =
          '${base_url}api/ClientCabinetBasic/GetAccountInformation';
      

      final http.Response accountInfoResponse = await http.post(
        Uri.parse(accountInfoUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"login": loginUserId, "token": loginToken}),
      );

      if (accountInfoResponse.statusCode == 200) {
        var accountInfoData = jsonDecode(accountInfoResponse.body);

        AccountInfoModel accountInfoModel =
            AccountInfoModel.fromJson(accountInfoData);

        String url =
            '${base_url}api/ClientCabinetBasic/GetLastFourNumbersPhone';
     

        var phoneNumberResponse = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"login": loginUserId, "token": loginToken}),
        );

        if (phoneNumberResponse.statusCode == 200) {
          var phoneNumberData = phoneNumberResponse.body;
          String phoneNumber = phoneNumberData.toString();

          accountInfoModel.phone = phoneNumber;

          return accountInfoModel;
        } else {}
      } else {
        customSnackBar(bgClr: snackBarErrorClr, msg: 'Somethings wants wrong');
      }
    } catch (error) {
      customSnackBar(bgClr: snackBarErrorClr, msg: error.toString());
    } finally {
      isLoading(false);
    }

    return null;
  }
}
