import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarkar_chit_fund/constant/route.dart';

import 'features/customer/ui/customer.dart';
import 'features/history/ui/customer_history.dart';
import 'features/login/ui/login_box.dart';
import 'utils/custom_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: CustomSnackbar.messagekey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: MyRoutes.login,
      getPages: [
        GetPage(name: MyRoutes.login, page: (() => const LoginPage())),
        GetPage(name: MyRoutes.customer, page: (() => const CustomerScreen())),
        GetPage(
            name: MyRoutes.customerDetails,
            page: (() => const CustomerDetails()))
      ],
    );
  }
}
