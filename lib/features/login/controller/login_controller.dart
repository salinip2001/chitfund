import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/baseurl.dart';
import 'package:http/http.dart' as http;

import '../../../api/endpoint.dart';
import '../../../utils/custom_snackbar.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> fetchlogin(String username, String userpassword) async {
    String status = '';
    final response = await http
        .get(ApiConfiguration().getApi(
            "${Endpoints.agent}?username=$username&userpassword=${userpassword.toUpperCase()}"))
        .then((value) async {
      final body = json.decode(value.body);
      print('userbody$body');
      if (body['status'] == 'success') {
        print('200$body');
        status = body['status'];
        CustomSnackbar.showSnackbar(
            'Login Verified', Colors.green, Icons.verified);
      } else {
        print('400$body');
        status = body['errors']['status'];
        CustomSnackbar.showSnackbar('Login Failed', Colors.red, Icons.warning);
      }
    }).catchError((onError) {
      status = onError.toString();
    });
    print(response);
    return status;
  }

  String StringToHex(String userpassword) {
    Encrypted encrypted = Encrypted.fromUtf8(userpassword);
    String result = encrypted.base16;
    return result;
  }
}
