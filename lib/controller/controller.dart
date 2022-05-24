import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:mana7yaha/model/comment_model.dart';

import '../model/fetch_requests.dart';

class Controller {
  static const String _database =
      'https://blood-donation-e61e7-default-rtdb.firebaseio.com/';

  static navigatorGO(Widget rout, BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => rout));

  static Future<List<CommentModel>> fetchComments({required String id}) async {
    List<CommentModel> comments = [];
    http.Response response =
        await http.get(Uri.parse(_database + 'request' + id + '.json'));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      data.forEach((key, value) {
        comments.add(CommentModel(name: value['name'], content: value['content']));
      });
    }

    return comments;
  }

  static Future<void> addComment(
      {required String id, required String content, required setState,required String name}) async {
    http.Response response = await http.post(
        Uri.parse(_database + 'request' + id + '.json'),
        body: json.encode({'content': content,'name':name}));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'تم اضافه تعليقك');
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: 'حدث خطا ما');
    }
  }

  static Future<List<FetchRequestsModel>> fetchRequests(
      BuildContext context) async {
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
      return data;
    } else {
      Fluttertoast.showToast(msg: 'حدث خطا ما');
      return data;
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
