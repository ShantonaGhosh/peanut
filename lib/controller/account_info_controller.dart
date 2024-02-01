
import 'package:get/get.dart';
import 'package:peanut/model/account_info_model.dart';
import 'package:peanut/service/account_info_service.dart';
import 'package:peanut/service/network_service.dart';

class AccountInfoController extends GetxController {
  var isLoading = false.obs;
  var isInternetStable = false.obs;
  var accountInfoList = <AccountInfoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    accountInfoListData();
  }

  Future<void> accountInfoListData() async {
    try {
      isLoading(true);

      await NetworkService.checkInternetConnectivity().then((internet) async {
        if (internet == true) {
          isInternetStable(true);
          AccountInfoModel? data = await AccountInfoService().getAccountInfo();
        
          accountInfoList.clear();
          accountInfoList.add(data!);
        } else {
          isInternetStable(false);
        }
      });
    } finally {
      isLoading(false);
    }
  }
}
