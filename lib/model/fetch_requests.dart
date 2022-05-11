class FetchRequestsModel {
  String? id, address, bloodType, date;

  FetchRequestsModel(
      {required this.id,
      required this.address,
      required this.bloodType,
      required this.date});

  FetchRequestsModel.fromJson({json, idJson}) {
    id = idJson;
    address = json['address'];
    bloodType = json['blood'];
    date = json['date'];
  }
}
