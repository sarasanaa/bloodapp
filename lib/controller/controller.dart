import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../model/fetch_requests.dart';

class Controller {
  static const String _database =
      'https://blood-donation-e61e7-default-rtdb.firebaseio.com/';

  static Future fetchRequests(BuildContext context) async {
    List<FetchRequestsModel> data = [];
    http.Response response =
        await http.get(Uri.parse(_database + 'request.json'));
    if (response.statusCode == 200) {
      Map jsonData = json.decode(response.body);
      jsonData.forEach((key, value) {
        data.add(
          FetchRequestsModel(
              id: key,
              address: value['address'],
              bloodType: value['blood'],
              date: value['date']),
        );
      });
    } else {
      Fluttertoast.showToast(msg: 'حدث خطا ما');
    }
  }

  static Future requstOFdonate(BuildContext context,
      {required String typeOfBlood, required String address}) async {
    debugPrint('function is start');
    DateTime date = DateTime.now();
    http.Response response = await http.post(
        Uri.parse(_database + 'request.json'),
        body: json.encode({
          'date': date.toString(),
          'blood': typeOfBlood,
          'address': address
        }));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      addToHistory(context: context, to: address);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('حدث خطا ما')));
    }
  }

  static Future addToHistory(
      {required BuildContext context, required String to}) async {
    http.Response response = await http.post(
        Uri.parse(_database + 'history.json'),
        body: json.encode({'date': DateTime.now(), 'to': to}));

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Some thing is wrong!!')));
    }
  }
}
