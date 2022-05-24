import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mana7yaha/model/user_model.dart';

import 'LoginPage.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void dispose() {
    super.dispose();
  }

  Future<UserModel> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) => loggedInUser = UserModel.fromMap(value.data()));
    return loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade800,
                  Colors.red.shade400,
                ],
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: FutureBuilder<UserModel>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    logout(context);
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "معلوماتي الشخصية",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: 'Baloobhaijaan2',
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: height * 0.66,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.72,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 70,
                                            ),
                                            Text(" ${snapshot.data?.blood}",
                                                style: TextStyle(
                                                  color: Colors.red.shade800,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 28,
                                                )),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                "إسم المتبرع : ${snapshot.data?.Name}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                )),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                "البريد الإلكتروني : ${snapshot.data?.email}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                )),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                "رقم الهاتف : ${snapshot.data?.phone}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                )),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                "مكان الاقامة : ${snapshot.data?.place}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                )),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                                "العمر  : ${snapshot.data?.age}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 20,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Container(
                                          child: Image.asset(
                                            'images/donorid.png',
                                            width: innerWidth * 0.45,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
