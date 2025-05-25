class MemberModelResponse {
  MemberModelResponse({
    required this.data,
    required this.message,
  });
  List<MemberModel> data;
  String message;

  factory MemberModelResponse.from(Map<String, dynamic> json) {
    return MemberModelResponse(
        message: json['status'],
        data: List<MemberModel>.from(
            json["data"].map((x) => MemberModel.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class MemberModel {
  final int? m_recno;
  final String? m_name;
  final String? m_no;
  final String? m_mobno;
  final String? m_adr1;
  final String? m_adr2;
  final String? m_adr3;
  final String? m_branchcode;

  MemberModel(
      {this.m_recno,
      this.m_name,
      this.m_no,
      this.m_mobno,
      this.m_adr1,
      this.m_adr2,
      this.m_adr3,
      this.m_branchcode});

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        m_recno:
            json['m_recno'] != null ? int.parse(json['m_recno'].toString()) : 0,
        m_name: json['m_name'] != null ? json['m_name'].toString() : '-',
        m_no: json['m_no'] != null ? json['m_no'].toString() : '-',
        m_mobno: json['m_mobno'] != null ? json['m_mobno'].toString() : '-',
        m_adr1: json['m_adr1'] != null ? json['m_adr1'].toString() : '-',
        m_adr2: json['m_adr2'] != null ? json['m_adr2'].toString() : '-',
        m_adr3: json['m_adr3'] != null ? json['m_adr3'].toString() : '-',
        m_branchcode: json['m_branchcode'] != null
            ? json['m_branchcode'].toString()
            : '-',
      );

  Map<String, dynamic> toJson() => {
        "m_recno": m_recno,
        "m_name": m_name,
        "m_no": m_no,
        "m_mobno": m_mobno,
        "m_adr1": m_adr1,
        "m_adr2": m_adr2,
        "m_adr3": m_adr3,
        "m_branchcode": m_branchcode
      };
}
