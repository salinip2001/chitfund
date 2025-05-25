class CustomerModelResponse {
  CustomerModelResponse({
    required this.data,
    required this.message,
  });
  List<CustomerModel> data;
  String message;

  factory CustomerModelResponse.from(Map<String, dynamic> json) {
    return CustomerModelResponse(
        message: json['status'],
        data: List<CustomerModel>.from(
            json["data"].map((x) => CustomerModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class CustomerModel {
  final String lname;
  final String address1;
  final String address2;
  final String address3;
  final String area;
  final String pincode;
  final String state;
  final String phoneno;
  final double discount;
  final String lgroup;
  final double lopbal;
  final String mobno;
  final int l_recno;
  final int lgrp_recno;
  final String branchcode;
  final String l_update;
  final String panno;
  final String gstno;
  final String aadharno;
  final String memno;
  final String finyear;
  final String root;

  CustomerModel(
      {required this.lname,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.area,
      required this.pincode,
      required this.state,
      required this.phoneno,
      required this.discount,
      required this.lgroup,
      required this.lopbal,
      required this.mobno,
      required this.l_recno,
      required this.lgrp_recno,
      required this.branchcode,
      required this.l_update,
      required this.panno,
      required this.gstno,
      required this.aadharno,
      required this.memno,
      required this.finyear,
      required this.root});

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      lname: json['lname'] != null ? json['lname'].toString() : '-',
      address1: json['address1'] != null ? json['address1'].toString() : '-',
      address2: json['address2'] != null ? json['address2'].toString() : '-',
      address3: json['address3'] != null ? json['address3'].toString() : '-',
      area: json['area'] != null ? json['area'].toString() : '-',
      pincode: json['pincode'] != null ? json['pincode'].toString() : '-',
      state: json['state'] != null ? json['state'].toString() : '-',
      phoneno: json['phoneno'] != null ? json['phoneno'].toString() : '-',
      discount: json['discount'] != null
          ? double.parse(json['discount'].toString())
          : 0.0,
      lgroup: json['lgroup'] != null ? json['lgroup'].toString() : '-',
      lopbal: json['lopbal'] != null
          ? double.parse(json['lopbal'].toString())
          : 0.0,
      mobno: json['mobno'] != null ? json['mobno'].toString() : '-',
      l_recno:
          json['l_recno'] != null ? int.parse(json['l_recno'].toString()) : 0,
      lgrp_recno: json['lgrp_recno'] != null
          ? int.parse(json['lgrp_recno'].toString())
          : 0,
      branchcode:
          json['branchcode'] != null ? json['branchcode'].toString() : '-',
      l_update: json['l_update'] != null ? json['l_update'].toString() : '-',
      panno: json['panno'] != null ? json['panno'].toString() : '-',
      gstno: json['gstno'] != null ? json['gstno'].toString() : '-',
      aadharno: json['aadharno'] != null ? json['aadharno'].toString() : '-',
      memno: json['memno'] != null ? json['memno'].toString() : '-',
      finyear: json['finyear'] != null ? json['finyear'].toString() : '-',
      root: json['root'] != null ? json['root'].toString() : '-');

  Map<String, dynamic> toJson() => {
        "lname": lname,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "area": area,
        "pincode": pincode,
        "state": state,
        "phoneno": phoneno,
        "discount": discount,
        "lgroup": lgroup,
        "lopbal": lopbal,
        "mobno": mobno,
        "l_recno": l_recno,
        "lgrp_recno": lgrp_recno,
        "branchcode": branchcode,
        "l_update": l_update,
        "panno": panno,
        "gstno": gstno,
        "aadharno": aadharno,
        "memno": memno,
        "finyear": finyear,
        "root": root
      };
}
