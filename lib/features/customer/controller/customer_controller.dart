import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/baseurl.dart';
import '../../../api/endpoint.dart';
import '../model/customer_model.dart';
import 'package:http/http.dart' as http;

import '../model/member_model.dart';

class CustomerController extends GetxController {
  // Customer TextEditingController
  TextEditingController customerNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController address3Controller = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController mobnoController = TextEditingController();

  // FocusNode
  FocusNode customerNameFocusNode = FocusNode();
  FocusNode address1FocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode address3FocusNode = FocusNode();
  FocusNode areaFocusNode = FocusNode();
  FocusNode mobNoFocusNode = FocusNode();

  List<CustomerModel> customerData = [];

  Future<void> getCustomerData() async {
    String status = '';
    final response = await http
        .get(ApiConfiguration().getApi(Endpoints.customer))
        .then((value) async {
      final body = json.decode(value.body);
      if (body['status'] == 'success') {
        final decodeData = CustomerModelResponse.from(body);
        customerData = decodeData.data;
        status = body['status'];
        print('customerbody$body');
      } else {
        status = body['errors']['status'];
      }
    }).catchError((onError) {
      status = onError.toString();
    });
  }

  // search in mobileno for search controller
  Future<void> getSearchData(String mobno) async {
    String status = '';
    final response = await http
        .get(ApiConfiguration().getApi("${Endpoints.search}?mobno=$mobno"))
        .then((value) async {
      final body = json.decode(value.body);
      if (body['status'] == 'success') {
        final decodeData = CustomerModelResponse.from(body);
        customerData = decodeData.data;
        status = body['status'];
      } else {
        status = body['errors']['status'];
      }
    }).catchError((onError) {
      status = onError.toString();
    });
    print(response);
  }

  // ledger recno
  Future<void> getCustomerrecno(int customerrecno) async {
    String status = '';
    final response = await http
        .get(ApiConfiguration().getApi(
            "${Endpoints.customer}/customerrecno?l_recno=$customerrecno"))
        .then((value) async {
      final body = json.decode(value.body);
      if (body['status'] == 'success') {
        final decodeData = CustomerModelResponse.from(body);
        customerData = decodeData.data;
        status = body['status'];
        print('customerrecnobody$body');
      } else {
        status = body['errors']['status'];
      }
    }).catchError((onError) {
      status = onError.toString();
    });
    print(response);
  }

  // insert newledger and memberentry
  Future<String> insertNewCustomer() async {
    String status = '';
    try {
      final url = Uri.parse(
          '${ApiConfiguration.url}newcustomer_newmember/insert-newledger');
      print('newledgerandmember$url');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'lname': customerNameController.text.toString().trim(),
            'lgroup': "CUSTOMER",
            'address1': address1Controller.text.toString().trim(),
            'address2': address2Controller.text.toString().trim(),
            'address3': address3Controller.text.toString().trim(),
            'area': areaController.text.toString().trim(),
            'mobno': mobnoController.text.toString().trim(),
            'l_recno': "",
            'branchcode': 'SHP',
            'memno': "",
            'm_recno': "",
            'm_name': customerNameController.text.toString().trim(),
            'm_no': "",
            'm_mobno': mobnoController.text.toString(),
            'm_adr1': address1Controller.text.toString().trim(),
            'm_adr2': address2Controller.text.toString().trim(),
            'm_adr3': address3Controller.text.toString().trim(),
            'm_branchcode': 'SHP'
          }));
      print('newbody${response.body}');
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'Insert Successfully') {
          status = body['status'];
          CustomerModel data = CustomerModel(
            lname: customerNameController.text.toString().trim(),
            lgroup: "CUSTOMER",
            lgrp_recno: 0,
            l_recno: 0,
            memno: "",
            lopbal: 0.0,
            finyear: "2324",
            mobno: mobnoController.text.toString(),
            branchcode: 'SHP',
            root: "",
            address1: address1Controller.text.toString().trim(),
            address2: address2Controller.text.toString().trim(),
            address3: address3Controller.text.toString().trim(),
            panno: '',
            area: areaController.text.toString().trim(),
            l_update: "",
            phoneno: mobnoController.text.toString(),
            pincode: "",
            state: "",
            discount: 0.0,
            gstno: "",
            aadharno: "",
          );
          MemberModel memberData = MemberModel(
              m_recno: 0,
              m_name: customerNameController.text.toString().trim(),
              m_no: "",
              m_mobno: mobnoController.text.toString(),
              m_adr1: address1Controller.text.toString().trim(),
              m_adr2: address2Controller.text.toString().trim(),
              m_adr3: address3Controller.text.toString().trim(),
              m_branchcode: "SHP");
        } else {
          status = 'insert failed';
        }
      }
    } catch (error) {
      status = error.toString();
    }
    return status;
  }
}
