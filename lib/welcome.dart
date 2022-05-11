import 'package:flutter/material.dart';
import 'package:mana7yaha/DelayedAnimation.dart';
import 'package:mana7yaha/LoginPage.dart';
import 'package:mana7yaha/main.dart';
import 'package:mana7yaha/sidebar.dart';
import 'package:mana7yaha/signup.dart';

import 'SocialPage.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                height: 430,
                child: Image.asset('images/group 4.png'),
              ),
              SizedBox(height: 30),
              Container(
                height: 100,
                child: Image.asset('images/2aya.jpg'),
              ),
              SizedBox(height: 60),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade800,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.all(10)),
                  child: Text(
                    'ابدأ',
                    style: TextStyle(
                      fontFamily: 'Baloobhaijaan2',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SocialPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
