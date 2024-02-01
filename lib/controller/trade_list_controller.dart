


import 'package:get/get.dart';
import 'package:peanut/model/trade_list_model.dart';
import 'package:peanut/service/network_service.dart';
import 'package:peanut/service/trade_list_service.dart';

class TradeListController {
  var isLoading = false.obs;
  var isInternetStable = false.obs;
  var tradeList = <TradeListModel>[].obs;



  Future<List<TradeListModel>> accountInfoListData() async {
    List<TradeListModel> data =[];
    try {
      isLoading(true);

      await NetworkService.checkInternetConnectivity().then((internet) async {
        if (internet == true) {
          isInternetStable(true);
      data = await TradeListService().getTradeList();
          tradeList.clear();
         
        } else {
          isInternetStable(false);
        }
      });
    } finally {
      isLoading(false);
    }
    return data;
  }
}
