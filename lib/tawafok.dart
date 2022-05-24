import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class tawafok extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red.shade800,
          title: const Text("توافق الزمر الدموية",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                height: 600,
                child: Image.asset('images/tabaro3.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
