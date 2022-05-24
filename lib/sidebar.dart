import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mana7yaha/AboutUs.dart';
import 'package:mana7yaha/LoginPage.dart';
import 'package:mana7yaha/NearPlaces.dart';
import 'package:mana7yaha/demandeur.dart';
import 'package:mana7yaha/profile.dart';
import 'package:mana7yaha/tawafok.dart';

class sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: Image.asset(
              "images/group 8.png",
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('الصفحة الرئيسية',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.home,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('حسابي الشخصي',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.account_box,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const profile()));
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('بحث عن متبرع',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.search,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const demandeur()));
              },
            ),
          ),
          const Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('الأماكن الأقرب',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.place,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NearPlaces()));
              },
            ),
          ),
          const Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text(' توافق الدم',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.bloodtype,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => tawafok()));
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('حول التطبيق',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.info,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              },
            ),
          ),
          const Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: const Text('تسجيل الخروج',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                logout(context);
              },
            ),
          ),
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
