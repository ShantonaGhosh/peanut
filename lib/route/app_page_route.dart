import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:peanut/main.dart';
import 'package:peanut/views/home_screen.dart';
import 'package:peanut/views/login_screen.dart';
import 'package:peanut/views/profile_screen.dart';
import 'package:peanut/views/route_page.dart';
import 'package:peanut/views/trade_list_screen.dart';

var getPages = [
  GetPage(name: "/", page: () => const MyApp()),
  GetPage(name: "/route", page: () => RoutePage()),
  GetPage(name: "/login", page: () => const LogInScreen()),
  GetPage(name: "/homeScreen", page: () => const HomeScreen()),
  GetPage(name: "/trade", page: () => const TradeListScreen()),
  GetPage(name: "/profileScreen", page: () => ProfileScreen()),
];
