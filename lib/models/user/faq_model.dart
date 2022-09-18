class FAQ {
  String? sId;
  String? question;
  String? answer;
  int? iV;

  FAQ({this.sId, this.question, this.answer, this.iV});

  FAQ.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['question'] = question;
    data['answer'] = answer;
    data['__v'] = iV;
    return data;
  }
}
