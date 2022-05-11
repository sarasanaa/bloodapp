import 'package:flutter/material.dart';
import 'package:mana7yaha/home.dart';
import 'package:mana7yaha/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  String? groupValue;

  final _formKey = GlobalKey<FormState>();

  List<String> _bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String _selected = '';
  bool _categorySelected = false;
  var dropDownValue, dropDownValPlace;

  final NameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final placeEditingController = TextEditingController();
  final bloodEditingController = TextEditingController();

  bool _acceptedTermsAndConditions = false;
  void _toggleTermsAndConditions(bool? value) {
    setState(() {
      _acceptedTermsAndConditions = !_acceptedTermsAndConditions;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Name field

    final NameField = TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return ("أدخل الاسم");
        }
        if (!regex.hasMatch(value)) {
          return ("ادخل اسم صالح");
        }
        return null;
      },
      onSaved: (value) {
        NameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "اسم المتبرع",
        labelStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("أدخل بريدك الالكتروني");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("البريد الإلكتروني غير صحيح");
          }
          return null;
        },
        onSaved: (value) {
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "البريد الإلكتروني",
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ));

    final phoneField = TextFormField(
        autofocus: false,
        controller: phoneEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return ("أدخل رقم هاتفك");
          }
          // reg expression for email validation
          if (!RegExp(r'(^0(5|6|7)[0-9]{8}$)').hasMatch(value)) {
            return ("رقم الهاتف غير صالح");
          }
          return null;
        },
        onSaved: (value) {
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "رقم الهاتف",
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ));
    //Age field
    final ageField = TextFormField(
        autofocus: false,
        controller: ageEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          int? age = int.tryParse(value!);
          if (age == null) {
            return ' أدخل عمرك';
          }
          if (age >= 65) {
            return ' لا يمكنك التبرع';
          }

          if (age <= 18) {
            return ' لا يمكنك التبرع';
          }

          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "العمر",
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ));
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("أدخل كلمة السر");
          }
          if (!regex.hasMatch(value)) {
            return ("كلمة السر غير صالحة");
          }
        },
        onSaved: (value) {
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "كلمة السر",
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "كلمة السر ليست نفسها";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "تأكيد كلمة السر",
          labelStyle: TextStyle(
            color: Colors.grey[400],
          ),
        ));

    final bloodField = DropdownButtonFormField(
        decoration: InputDecoration(),
        value: dropDownValue,
        hint: const Text("اختر زمرة الدم"),
        items: _bloodGroup.map((_selected) {
          return DropdownMenuItem<String>(
            value: _selected,
            child: Text(_selected),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return "ادخل زمرة الدم";
          }
        },
        onSaved: (value) {
          bloodEditingController.text = value!.toString();
        },
        onChanged: (newValue) {
          setState(() {
            dropDownValue = newValue;
            bloodEditingController.text = newValue.toString();
            this._categorySelected = true;
          });
        });
    SizedBox(
      height: 10.0,
    );
    Text(
      _selected,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Color.fromARGB(1000, 221, 46, 68),
      ),
    );
    final placeField = DropdownButtonFormField(
        value: dropDownValPlace,
        decoration: InputDecoration(),
        hint: const Text("اختر البلدية"),
        items: const [
          DropdownMenuItem(
            child: Text("عين الحجر"),
            value: "عين الحجر",
          ),
          DropdownMenuItem(
            child: Text("عين السخونة"),
            value: "عين السخونة",
          ),
          DropdownMenuItem(
            child: Text("عين سلطان"),
            value: "عين سلطان",
          ),
          DropdownMenuItem(
            child: Text("ذوي ثابت"),
            value: "ذوي ثابت",
          ),
          DropdownMenuItem(
            child: Text("الحساسنة"),
            value: "الحساسنة",
          ),
          DropdownMenuItem(
            child: Text("معمورة"),
            value: "معمورة",
          ),
          DropdownMenuItem(
            child: Text("مولاي لعربي"),
            value: "مولاي لعربي",
          ),
          DropdownMenuItem(
            child: Text("أولاد براهيم"),
            value: "أولاد براهيم",
          ),
          DropdownMenuItem(
            child: Text("أولاد خالد"),
            value: "أولاد خالد",
          ),
          DropdownMenuItem(
            child: Text("سيدي أحمد"),
            value: "سيدي أحمد",
          ),
          DropdownMenuItem(
            child: Text("سيدي أعمر"),
            value: "سيدي أعمر",
          ),
          DropdownMenuItem(
            child: Text("سيدي بوبكر"),
            value: "سيدي بوبكر",
          ),
          DropdownMenuItem(
            child: Text("تيرسين"),
            value: "تيرسين",
          ),
          DropdownMenuItem(
            child: Text("يوب"),
            value: "أيوب",
          ),
          DropdownMenuItem(
            child: Text("هونة"),
            value: "هونة",
          ),
          DropdownMenuItem(
            child: Text("سعيدة"),
            value: "سعيدة",
          ),
        ],
        validator: (value) {
          if (value == null) {
            return "ادخل البلدية";
          }
        },
        onSaved: (value) {
          placeEditingController.text = value!.toString();
        },
        onChanged: (newValue) {
          setState(() {
            dropDownValPlace = newValue;
            _selected != newValue;
            this._categorySelected = true;
          });
        });

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red.shade800,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: Text(
            "تسجيل",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("إنشاء حساب جديد"),
          centerTitle: true,
          elevation: 4.0,
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 100,
                          child: Image.asset(
                            "images/group 8.png",
                            width: 110,
                          )),
                      SizedBox(height: 45),
                      NameField,
                      SizedBox(height: 20),
                      phoneField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      ageField,
                      SizedBox(height: 20),
                      passwordField,
                      SizedBox(height: 20),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      bloodField,
                      SizedBox(height: 20),
                      placeField,
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptedTermsAndConditions,
                            onChanged: _toggleTermsAndConditions,
                          ),
                          Flexible(
                            child: Text(
                                "وزني فوق 50 و لا اعاني من امراض مزمنة او معدية"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      signUpButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate() && _acceptedTermsAndConditions) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values

    userModel.email = user!.email;
    userModel.age = ageEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.uid = user.uid;
    userModel.place = dropDownValPlace;
    userModel.blood = dropDownValue;
    userModel.Name = NameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "تم انشاء حسابك بنجاح :)  ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => home()), (route) => false);
  }
}
