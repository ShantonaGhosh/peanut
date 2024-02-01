import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/common/app_color.dart';
import 'package:peanut/controller/trade_list_controller.dart';
import 'package:peanut/model/trade_list_model.dart';
import 'package:peanut/service/network_service.dart';
import 'package:peanut/service/trade_list_service.dart';
import 'package:peanut/widget/custom_appbar.dart';
import 'package:peanut/widget/custom_progress_indicator.dart';
import 'package:peanut/widget/my_text_style.dart';
import 'package:peanut/widget/no_connection_msg.dart';

class TradeListScreen extends StatefulWidget {
  const TradeListScreen({super.key});

  @override
  State<TradeListScreen> createState() => _TradeListScreenState();
}

class _TradeListScreenState extends State<TradeListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var isLoading = false;
  var isInternetStable = true;
  double totalProfit = 0.0;

  List<TradeListModel> tradeList = [];
  List<TradeListModel> finalList = [];
  // ----------Refresh this UI-----------
  Future refresh() async {
    await getVisitList();
    profit();
  }
  
  // -------------------------------API data get function------------

  Future getVisitList() async {
    await NetworkService.checkInternetConnectivity().then((internet) async {
      if (internet == true) {
        isLoading = true;
        isInternetStable = true;
        setState(() {});
        List<TradeListModel> data = await TradeListService().getTradeList();
        setState(
          () {
            tradeList = data;
            finalList = tradeList;
            isLoading = false;
         
          },
        );
      } else {
        isInternetStable = false;
        isLoading = false;
        setState(() {});
      }
    });
  }

  //------------------Total Profit calculate-----------

  double profit() {
    totalProfit = 0.0;
    for (var element in finalList) {
      totalProfit += element.profit;
    }

    setState(() {});
   
    return totalProfit;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.put(TradeListController());
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(
        title: Text('Trade List'),
      ),
      floatingActionButton: isInternetStable == false
          ? const SizedBox()
          : finalList.isEmpty
              ? FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () {
                    refresh();
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
      body: !isInternetStable
          ? NoConnectionMsg(onTap: () {
              refresh();
              setState(() {});
            })
          : Stack(
              children: [
                Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.fromLTRB(12.0, 15.0, 12.0, 60.0),
                  child: Column(
                    children: [
                      isLoading
                          ? Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: CustomProgressIndicator(),
                              ),
                            )
                          : tradeList.isEmpty
                              ? Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: const Text('No Data found')),
                                )
                              : Expanded(
                                  child: RefreshIndicator(
                                    backgroundColor: kPrimaryColor,
                                    color: Colors.white,
                                    onRefresh: () => refresh(),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: finalList.length,
                                      itemBuilder: (context, index) {
                                        var item = finalList[index];

                                        return Card(
                                          elevation: 5.0,
                                         
                                          color: Colors.grey.shade300,
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            margin: const EdgeInsets.only(
                                                bottom: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              
                                              color: Colors.grey.shade300,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Current Price : ${item.currentPrice}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Profit : ${item.profit}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Open Price : ${item.openPrice}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'Volume : ${item.volume}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'SL : ${item.sl}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  'swaps : ${item.swaps}',
                                                  style: myTextStyle(
                                                    size: 16.0,
                                                    clr: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Divider(
                                                  height: 1,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Colors.black12),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Open Time: ${item.openTime}",
                                                    style: myTextStyle(
                                                      clr: Colors.red,
                                                      fw: FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,

                     
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0)),
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 10, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Total Profit : ${totalProfit.toStringAsFixed(2)}',
                              style: myTextStyle(clr: Colors.white, size: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
