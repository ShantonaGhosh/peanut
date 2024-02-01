import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peanut/common/app_color.dart';
import 'package:peanut/common/variables.dart';
import 'package:peanut/model/trade_list_model.dart';
import 'package:peanut/widget/custom_snackbar.dart';

class TradeListService extends GetConnect {
  static var isLoading = false.obs;
  GetStorage userData = GetStorage();

  Future<List<TradeListModel>> getTradeList() async {
    List<TradeListModel> tradeListModel = [];
    try {
      isLoading(true);
      String url =
          'https://peanut.ifxdb.com/api/ClientCabinetBasic/GetOpenTrades';

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"login": loginUserId, "token": loginToken}),
      );

      if (response.statusCode == 200) {
        tradeListModel = tradeListModelFromJson(response.body);

        return tradeListModel;
      } else {
        customSnackBar(bgClr: snackBarErrorClr, msg: 'Somethings wants wrong');
        return tradeListModel;
      }
    } finally {
      isLoading(false);
    }
  }
}
