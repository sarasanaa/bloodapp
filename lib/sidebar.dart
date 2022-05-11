import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mana7yaha/AboutUs.dart';
import 'package:mana7yaha/LoginPage.dart';
import 'package:mana7yaha/NearPlaces.dart';
import 'package:mana7yaha/profile.dart';
import 'package:mana7yaha/NearPlaces.dart';
import 'package:mana7yaha/tawafok.dart';
import 'package:mana7yaha/welcome.dart';

class sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 20),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Image.asset(
              "images/group 8.png",
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text('الصفحة الرئيسية',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
                Icons.home,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text('حسابي الشخصي',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
                Icons.account_box,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text('الاشعارات',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
                Icons.notifications,
                color: Colors.red,
                size: 25,
              ),
              onTap: () => null,
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text('الأماكن الأقرب',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
                Icons.place,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NearPlaces()));
              },
            ),
          ),
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text(' توافق الدم',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
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
              title: Text('حول التطبيق',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
                Icons.info,
                color: Colors.red,
                size: 25,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ),
          Divider(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              title: Text('تسجيل الخروج',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
              leading: Icon(
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
