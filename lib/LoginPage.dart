import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mana7yaha/reset.dart';
import 'package:mana7yaha/signup.dart';
import 'package:mana7yaha/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("أدخل بريدك الإلكتروني");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("البريد الإلكتروني غير صحيح");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'البريد الإلكتروني',
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.email,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      obscureText: _obscureText,
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("أدخل كلمة السر");
        }
        if (!regex.hasMatch(value)) {
          return ("كلمة السر التي أدخلتها غير صحيحة");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
        labelText: 'كلمة السر',
        suffixIcon: IconButton(
          icon: Icon(
            Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red.shade800,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text(
          'دخول',
          style: TextStyle(
            fontFamily: 'Baloobhaijaan2',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تسجيل الدخول"),
          centerTitle: true,
          backgroundColor: Colors.red.shade800,
          elevation: 4.0,
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
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Image.asset("images/login.png"),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "تبرعك حياة لغيرك",
                                style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  color: Colors.red[800],
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "سجل بياناتك كمتبرع الان",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Baloobhaijaan2',
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 40),
                              emailField,
                              SizedBox(height: 25),
                              passwordField,
                              SizedBox(height: 15),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetScreen()));
                                      },
                                      child: Text(
                                        "نسيت كلمة السر ؟",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    )
                                  ]),
                              SizedBox(height: 17),
                              loginButton,
                              SizedBox(height: 15),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("لم تسجل بعد ؟ "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    signup()));
                                      },
                                      child: Text(
                                        "انشاء حساب جديد",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) {
          Fluttertoast.showToast(msg: "تم التسجيل بنجاح");
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => home()));
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "خطأ في البريد الإلكتروني";

            break;
          case "wrong-password":
            errorMessage = "كلمة السر خاطئة";
            break;
          case "user-not-found":
            errorMessage = "البريد الإلكتروني الذي أدخلته غير مرتبط بحساب";
            break;
          case "operation-not-allowed":
            errorMessage = "خطأ في البريد الإلكتروني او كلمة السر";
            break;
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
