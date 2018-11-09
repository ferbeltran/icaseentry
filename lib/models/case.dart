import 'package:icaseentry/models/detail.dart';


class Case {
 int pk;
 String caseNumber;
 String date;
 String customer;
 String database;
 String user;
 String status;
 String type;
 String assignedUser;
 String subject;
 String description;
 int minutes;
 String createdBy;
 List<Detail> details;

 Case({
   this.pk, this.caseNumber, this.date, this.database, this.customer, this.user, this.status, this.type,
   this.assignedUser, this.subject, this.description, this.minutes, this.createdBy, this.details
 });

 Case.fromJson(Map<String, dynamic> map) {
    pk = map['PK'];
    caseNumber = map['CaseEntryNo'];
    date = map['CaseEntryDate'].substring(6,19);
    database = map['DbEntity'];
    customer = map['Customer'];
    user = map['User'];
    status = map['Status'];
    subject = map['Subject'];
    type = map['Type'];
    description = map['Description'];
    minutes = map['TotalMinutes'];
    createdBy = map['CreatedByUser']; 
    details = map['Details'].map<Detail>((d) => Detail.fromJson(d)).toList();

   
 }

    
}