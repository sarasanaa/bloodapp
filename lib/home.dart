import 'package:flutter/material.dart';
import 'package:mana7yaha/demandeur.dart';
import 'package:mana7yaha/profile.dart';
import 'package:mana7yaha/mymap.dart';
import 'package:mana7yaha/sidebar.dart';
import 'package:mana7yaha/view/screens/fetch_blood.dart';

class home extends StatefulWidget {
  @override
  _home createState() => _home();
}

class _home extends State<home> {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: sidebar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'images/sang1.jpg',
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'من أحياها',
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.red[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mymap()));
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(
                          left: 40.0, top: 50.0, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/placeholder.png',
                            height: 65,
                            width: 60,
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            "موقعي",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'BalooBhaijaan2',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const demandeur()));
                    },
                    child: Container(
                      width: 100,
                      margin:
                          const EdgeInsets.only(left: 5, top: 50.0, right: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/blood (1).png',
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "البحث عن متبرع",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'BalooBhaijaan2',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FetchBlood()));
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(
                          left: 40.0, top: 5, right: 5, bottom: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/clipboard.png',
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "طلبات التبرع",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'BalooBhaijaan2',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const profile()));
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(
                          left: 5, top: 5, right: 40, bottom: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/blood (2).png',
                            height: 60,
                            width: 60,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "حسابي",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'BalooBhaijaan2',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
