import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peanut/common/app_color.dart';
import 'package:peanut/controller/account_info_controller.dart';

import 'package:peanut/service/auth_services.dart';
import 'package:peanut/service/network_service.dart';
import 'package:peanut/widget/custom_appbar.dart';
import 'package:peanut/widget/custom_button.dart';
import 'package:peanut/widget/custom_card.dart';
import 'package:peanut/widget/custom_progress_indicator.dart';
import 'package:peanut/widget/network_failed_dialog.dart';
import 'package:peanut/widget/no_connection_msg.dart';

class ProfileScreen extends GetView<AccountInfoController> {
  ProfileScreen({super.key});
  final GetStorage userData = GetStorage();

  @override
  Widget build(BuildContext context) {
    Get.put(AccountInfoController());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('User Profile'),
      ),
      // ------------------------------Reload api data-------------
      floatingActionButton: Obx(
        () => controller.isInternetStable.value == false
            ? const SizedBox()
            : controller.accountInfoList.isEmpty
                ? FloatingActionButton(
                    onPressed: () => _refresh(),
                    backgroundColor: kPrimaryColor,
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
      ),

      body: Obx(
        () => controller.isInternetStable.value == false
            ? NoConnectionMsg(onTap: () async {
                _refresh();

              })
            :  controller.accountInfoList.isEmpty
                ? CustomProgressIndicator()
                : Container(
                    height: size.height,
                    width: size.width,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: kPrimaryColor,
                            child: Icon(
                              Icons.person_outline_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomCard(
                            firstText: Text(
                              'Name : ${controller.accountInfoList.first.name}',
                            ),
                            title: '',
                          ),
                          CustomCard(
                              firstText: Text(
                                'Phone :${controller.accountInfoList.first.phone} ',
                              ),
                              title: ''),
                          CustomCard(
                              firstText: Text(
                                'Balance :${controller.accountInfoList.first.balance} ',
                              ),
                              title: ''),
                          CustomCard(
                              firstText: Text(
                                'Country:${controller.accountInfoList.first.country} ',
                              ),
                              title: ''),
                          CustomCard(
                              firstText: Text(
                                'Total Trades Count :${controller.accountInfoList.first.totalTradesCount}',
                              ),
                              title: ''),
                          CustomCard(
                              firstText: Text(
                                'Total Trades Volume : ${controller.accountInfoList.first.totalTradesVolume}',
                              ),
                              title: ''),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: size.width * 0.07,
                            child: CustomButton(
                              onTap: () async {
                                await AuthServices().logOut();
                              },
                              title: "Log Out",
                              fontSize: 16,
                              btnColor: kPrimaryColor,
                              fontColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  // ---------------------Refresh Full UI-------------------

  Future _refresh() async {
    await NetworkService.checkInternetConnectivity().then((internet) {
      if (internet == true) {
        controller.onInit();
      } else {
        networkFailedDialog(
          tryAgainOnTap: () {
            Get.back(canPop: false);
            _refresh();
          },
        );
      }
    });
  }
}
