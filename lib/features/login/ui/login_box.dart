import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarkar_chit_fund/features/collection/controller/collection_controller.dart';

import '../../../constant/route.dart';
import '../../../constant/strings.dart';
import '../../../widgets/uppercase_textfield.dart';
import '../../customer/controller/customer_controller.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());
  final customerController = Get.put(CustomerController());
  final collectionController = Get.put(CollectionController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    final style = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: ClipRRect(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: _mediaQuery.width > 700
                    ? _mediaQuery.height * 0.55
                    : _mediaQuery.height * 0.65,
                width: _mediaQuery.width > 700
                    ? _mediaQuery.width * 0.3
                    : _mediaQuery.width * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/auth_banner.png'),
                    ),
                    Text(
                      MyStrings.loginName,
                      style: style.textTheme.labelLarge!.copyWith(
                        color: style.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: loginController.userNameController,
                      cursorColor: Colors.black,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: MyStrings.hintUser,
                        hintStyle: const TextStyle(color: Colors.black),
                        labelText: MyStrings.userName,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      controller: loginController.passwordController,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: MyStrings.hintPassword,
                        hintStyle: const TextStyle(color: Colors.black),
                        labelText: MyStrings.userPassword,
                        prefixIcon: const Icon(
                          Icons.keyboard,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              await customerController.getCustomerData();
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await loginController
                                    .fetchlogin(
                                        loginController.userNameController.text
                                            .toString(),
                                        loginController.StringToHex(
                                            loginController
                                                .passwordController.text
                                                .toString()
                                                .trim()))
                                    .then((value) {
                                  if (value == 'success') {
                                    Get.toNamed(
                                      MyRoutes.customer,
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                              }
                            },
                      child: Text(
                        MyStrings.loginName,
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _sumbit() async {
  //   await customerController.getCustomerData();
  //   FocusScope.of(context).unfocus();
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     await loginController
  //         .fetchlogin(
  //             loginController.userNameController.text.toString(),
  //             loginController.StringToHex(
  //                 loginController.passwordController.text.toString().trim()))
  //         .then((value) {
  //       if (value == 'success') {
  //         Get.toNamed(
  //           MyRoutes.customer,
  //         );
  //       }
  //     });
  //   }
  // }
}
