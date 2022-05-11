import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mana7yaha/DelayedAnimation.dart';
import 'package:mana7yaha/demandeur.dart';
import 'package:mana7yaha/main.dart';

import 'LoginPage.dart';

class SocialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red.shade800,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    DelayedAnimation(
                      delay: 1500,
                      child: Container(
                        height: 280,
                        child: Image.asset('images/photo1.png'),
                      ),
                    ),
                    SizedBox(height: 50),
                    DelayedAnimation(
                      delay: 3500,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 40,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.red.shade800,
                                padding: EdgeInsets.all(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    'أنا المتبرع',
                                    style: TextStyle(
                                      fontFamily: 'Baloobhaijaan2',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: (20)),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => demandeur(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Colors.white,
                                padding: EdgeInsets.all(13),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    'بحث عن متبرع',
                                    style: TextStyle(
                                      fontFamily: 'Baloobhaijaan2',
                                      color: Colors.red.shade800,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
