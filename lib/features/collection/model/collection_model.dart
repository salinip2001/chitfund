class CollectionModelResponse {
  CollectionModelResponse({
    required this.data,
    required this.message,
  });
  List<CollectionModel> data;
  String message;

  factory CollectionModelResponse.fromJson(Map<String, dynamic> json) {
    return CollectionModelResponse(
        message: json['status'],
        data: List<CollectionModel>.from(
            json["data"].map((x) => CollectionModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class CollectionModel {
  final int? c_recno;
  final String? c_pfx;
  final int? c_no;
  final String? c_date;
  final String? c_update;
  final String? c_time;
  final double? c_amount;
  final String? c_type;
  final double? adjamount;
  final String? c_relisedate;
  final String? c_depositeddate;
  final int? c_ledrecno;
  final String? c_grouptype;

  CollectionModel(
      {this.c_recno,
      this.c_pfx,
      this.c_no,
      this.c_date,
      this.c_update,
      this.c_time,
      this.c_amount,
      this.c_type,
      this.adjamount,
      this.c_relisedate,
      this.c_depositeddate,
      this.c_ledrecno,
      this.c_grouptype});

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
          c_recno: json['c_recno'] != null
              ? int.parse(json['c_recno'].toString())
              : 0,
          c_pfx: json['c_pfx'] != null ? json['c_pfx'].toString() : '-',
          c_no: json['c_no'] != null ? int.parse(json['c_no'].toString()) : 0,
          c_date: json['c_date'] != null ? json['c_date'].toString() : '-',
          c_update:
              json['c_update'] != null ? json['c_update'].toString() : '-',
          c_time: json['c_time'] != null ? json['c_time'].toString() : '-',
          c_amount: json['c_amount'] != null
              ? double.parse(json['c_amount'].toString())
              : 0.0,
          c_type: json['c_type'] != null ? json['c_type'].toString() : '-',
          adjamount: json['adjamount'] != null
              ? double.parse(json['adjamount'].toString())
              : 0.0,
          c_relisedate: json['c_relisedate'] != null
              ? json['c_relisedate'].toString()
              : '-',
          c_depositeddate: json['c_depositeddate'] != null
              ? json['c_depositeddate'].toString()
              : '-',
          c_ledrecno: json['c_ledrecno'] != null
              ? int.parse(json['c_ledrecno'].toString())
              : 0,
          c_grouptype: json['c_grouptype'] != null
              ? json['c_grouptype'].toString()
              : '-');

  Map<String, dynamic> toJson() => {
        "c_recno": c_recno,
        "c_pfx": c_pfx,
        "c_no": c_no,
        "c_date": c_date,
        "c_update": c_update,
        "c_time": c_time,
        "c_amount": c_amount,
        "c_type": c_type,
        "adjamount": adjamount,
        "c_relisedate": c_relisedate,
        "c_depositeddate": c_depositeddate,
        "c_ledrecno": c_ledrecno,
        "c_grouptype": c_grouptype
      };
}
