class GroupModelResponse {
  GroupModelResponse({
    required this.data,
    required this.message,
  });
  List<GroupModel> data;
  String message;

  factory GroupModelResponse.fromJson(Map<String, dynamic> json) {
    return GroupModelResponse(
        message: json['status'],
        data: List<GroupModel>.from(
            json["data"].map((x) => GroupModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class GroupModel {
  final int? g_recno;
  final String? g_name;
  final int? g_installment;
  final double? g_minvalue;
  final double? g_maxvalue;
  final double? g_totalamt;
  GroupModel(
      {this.g_recno,
      this.g_name,
      this.g_installment,
      this.g_minvalue,
      this.g_maxvalue,
      this.g_totalamt});

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        g_recno:
            json['g_recno'] != null ? int.parse(json['g_recno'].toString()) : 0,
        g_name: json['g_name'] != null ? json['g_name'].toString() : '-',
        g_installment: json['g_installment'] != null
            ? int.parse(json['g_installment'].toString())
            : 0,
        g_minvalue: json['g_minvalue'] != null
            ? double.parse(json['g_minvalue'].toString())
            : 0.0,
        g_maxvalue: json['g_maxvalue'] != null
            ? double.parse(json['g_maxvalue'].toString())
            : 0.0,
        g_totalamt: json['g_totalamt'] != null
            ? double.parse(json['g_totalamt'].toString())
            : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "g_recno": g_recno,
        "g_name": g_name,
        "g_installment": g_installment,
        "g_minvalue": g_minvalue,
        "g_maxvalue": g_maxvalue,
        "g_totalamt": g_totalamt,
      };
}
