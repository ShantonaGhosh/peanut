import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:peanut/common/variables.dart';
import 'package:peanut/widget/custom_appbar.dart';

import '../widget/custom_drawer.dart';
import '../widget/my_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GetStorage userData = GetStorage();

  final List _itemList = [
    {
      "title": "Trade",
      "image": Image.asset('assets/images/trade.png'),
      "page": "/trade",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: const Text('Home Screen'),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('$loginUserId'),
                    minLeadingWidth: 10,
                  ),
                ),
              ),
              SizedBox(
                height: size.height,
                width: size.width,
                child: GridView.builder(
                    itemCount: _itemList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (() {
                          Get.toNamed(
                            '${_itemList[index]["page"]}',
                          );
                        }),
                        child: Card(
                          elevation: 1.0,
                          color: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.08,
                                child: _itemList[index]['image'],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _itemList[index]['title'],
                                textAlign: TextAlign.center,
                                style: myTextStyle(
                                    
                                    size: 15.5,
                                    clr: Colors.black54,
                                    fw: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
