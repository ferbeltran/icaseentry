class Detail {
  String caseEntryNumber;
  String comments;
  String date;
  int detailNumber;
  String doneBy;
  String from;
  int minutes;
  String to;

  Detail(
      {this.caseEntryNumber,
      this.comments,
      this.date,
      this.detailNumber,
      this.doneBy,
      this.from,
      this.minutes,
      this.to});

  Detail.fromJson(Map<String, dynamic> json) 
      : caseEntryNumber = json["CaseEntryNo"],
        comments = json["Comments"],
        date = json['CaseEntryDate'] != null ? json['CaseEntryDate'].substring(6, 19) : "",
        detailNumber = json["DetailNo"],
        doneBy = json["DoneBy"],
        from = json['From'] != null ? json['From'].substring(6, 19) : "",
        minutes = json["Minutes"],
        to = json['To'] != null ? json['To'].substring(6, 19) : "";
}
