import 'package:cloud_firestore/cloud_firestore.dart';

class UserDonationsModel {
  String? donationAddress;
  String? donationDate;
  String? PatientName;
  String? donationNotes;

  UserDonationsModel({
    required this.donationAddress,
    required this.donationDate,
    required this.PatientName,
    required this.donationNotes,
  });

  UserDonationsModel.fromSnapshot(DocumentSnapshot snapshot)
      : PatientName = snapshot[Strings.hPatientName];
}

class Strings {
  // Firebase User Donations History Collection Strings
  static const String userDonationsHistoryCollection =
      'userDonationsHistoryCollection';
  static const String donationAddress = 'donationAddress';
  static const String donationDate = 'donationDate';
  static const String hPatientName = 'PatientName';
  static const String donationNotes = 'donationNotes';
}
