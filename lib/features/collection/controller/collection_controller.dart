import 'dart:convert';

import 'package:get/get.dart';

import '../../../api/baseurl.dart';
import '../../../api/endpoint.dart';
import '../model/collection_model.dart';
import 'package:http/http.dart' as http;

class CollectionController extends GetxController {
  Future<List<CollectionModel>> getCollectionData(int ledrecno) async {
    List<CollectionModel> collectionData = await http
        .get(
            ApiConfiguration()
                .getApi("${Endpoints.collection}?c_ledrecno=$ledrecno"),
            headers: ApiConfiguration.header)
        .then((value) {
      final body = json.decode(value.body);
      print(body);
      if (value.statusCode == 200) {
        final collection = CollectionModelResponse.fromJson(body);
        return collection.data;
      } else {
        return <CollectionModel>[];
      }
    }).catchError((onError) {
      print(onError);
      return <CollectionModel>[];
    });
    return collectionData;
  }

  // insert collection entry
  Future<String> insertCollection(CollectionModel collectionModel) async {
    String status = '';
    try {
      final url =
          Uri.parse('${ApiConfiguration.url}collection/insert-collection');
      print('insertcollection$url');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'c_recno': 0,
            'c_pfx': "MCH2324",
            'c_no': 0,
            'c_date': collectionModel.c_date.toString(),
            'c_amount': collectionModel.c_amount.toString(),
            'c_type': collectionModel.c_type.toString(),
            'adjamount': collectionModel.adjamount.toString(),
            'c_ledrecno': collectionModel.c_ledrecno.toString(),
            'c_time': collectionModel.c_time.toString(),
            'c_grouptype': collectionModel.c_grouptype.toString()
          }));
      print('newbody${response.body}');
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['status'] == 'Insert Successfully') {
          status = body['status'];
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
