import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mana7yaha/controller/controller.dart';
import 'package:mana7yaha/controller/my_sizer.dart';
import 'package:mana7yaha/model/comment_model.dart';
import 'package:mana7yaha/model/user_model.dart';

import 'package:mana7yaha/view/wiget/text_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/user_model.dart';

class AddComment extends StatefulWidget {
  AddComment({Key? key, required this.id}) : super(key: key);
  String? id;

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  TextEditingController comment = TextEditingController();

//minou@gmail.com
  //minouchbab
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? name;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      SharedPreferences.getInstance().then((value) => value.getString('name'));
      setState(() {});
    });
  }

  Future<String?> getSavedData({required String key}) async {
    String? data = await SharedPreferences.getInstance()
        .then((value) => value.getString(key));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التعليقات'),
          centerTitle: true,
          backgroundColor: Colors.red.shade800,
        ),
        body: FutureBuilder<List<CommentModel>>(
          future: Controller.fetchComments(id: widget.id ?? ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasData == false) {
              return SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: MySizer.h(context) * .8,
                          child: const Text('..لا توجد تعليقات ')),
                      SizedBox(
                        height: MySizer.h(context) / 10,
                        child: TextForm(
                          hint: 'اضف تعليق',
                          controller: comment,
                          widget: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              Controller.addComment(
                                id: widget.id ?? '',
                                content: comment.text,
                                name: loggedInUser.Name ?? '',
                                setState: setState,
                              );

                              comment.clear();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    SizedBox(
                      height: MySizer.h(context) * .8,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data!.isEmpty
                              ? const Center(
                                  child: Text('لا توجد تعليقات'),
                                )
                              : Card(
                                  child: ListTile(
                                    trailing: IconButton(
                                      icon: const Icon(Icons.phone,
                                          color: Colors.green),
                                      onPressed: () {
                                        launch('tel://${loggedInUser.phone}');
                                      },
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/5073/5073415.png'),
                                      backgroundColor: Colors.white,
                                    ),
                                    title:
                                        Text(snapshot.data?[index].name ?? ''),
                                    subtitle: Text(
                                        snapshot.data?[index].content ?? ''),
                                  ),
                                );
                        },
                      ),
                    ),
                    SizedBox(
                      height: MySizer.h(context) / 10,
                      child: TextForm(
                        hint: 'اضف تعليق',
                        controller: comment,
                        widget: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            Controller.addComment(
                              id: widget.id ?? '',
                              content: comment.text,
                              name: loggedInUser.Name ?? '',
                              setState: setState,
                            );

                            comment.clear();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
