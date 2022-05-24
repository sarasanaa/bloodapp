import 'package:flutter/material.dart';
import 'package:mana7yaha/LoginPage.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                height: 430,
                child: Image.asset('images/group 4.png'),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 100,
                child: Image.asset('images/2aya.jpg'),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade800,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(10)),
                  child: const Text(
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
                        builder: (context) => LoginPage(),
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
