import 'dart:convert';

import 'package:get/get.dart';

import '../../../api/baseurl.dart';
import '../../../api/endpoint.dart';
import '../model/group_model.dart';
import 'package:http/http.dart' as http;

class CustomerHistoryController extends GetxController {
  List<GroupModel> groupData = [];
  int pIndex = -1.obs;
  var totalUnits = 0.0.obs;

  // Future<void> getGroupData(String agName) async {
  //   String status = '';
  //   final response = await http
  //       .get(ApiConfiguration().getApi("${Endpoints.group}?ag_name=$agName"))
  //       .then((value) async {
  //     final body = json.decode(value.body);
  //     if (body['status'] == 'success') {
  //       final decodeData = GroupModelResponse.from(body);
  //       groupData = decodeData.data;
  //       status = body['status'];
  //       print('groupbody$body');
  //     } else {
  //       status = body['errors']['status'];
  //     }
  //   }).catchError((onError) {
  //     status = onError.toString();
  //   });
  // }

  Future<List<GroupModel>> getGroupData(String gName) async {
    List<GroupModel> groupData = await http
        .get(ApiConfiguration().getApi("${Endpoints.group}?g_name=$gName"),
            headers: ApiConfiguration.header)
        .then((value) {
      final body = json.decode(value.body);
      print('group$body');
      if (value.statusCode == 200) {
        final group = GroupModelResponse.fromJson(body);
        return group.data;
      } else {
        return <GroupModel>[];
      }
    }).catchError((onError) {
      print(onError);
      return <GroupModel>[];
    });
    return groupData;
  }

  // get normal groupData
  Future<List<GroupModel>> getGroupAllData() async {
    List<GroupModel> groupData = await http
        .get(ApiConfiguration().getApi("${Endpoints.group}/alldata"),
            headers: ApiConfiguration.header)
        .then((value) {
      final body = json.decode(value.body);
      print('groupall$body');
      if (value.statusCode == 200) {
        final group = GroupModelResponse.fromJson(body);
        return group.data;
      } else {
        return <GroupModel>[];
      }
    }).catchError((onError) {
      print(onError);
      return <GroupModel>[];
    });
    return groupData;
  }

  
}
