import 'package:flutter/material.dart';
import 'package:mana7yaha/controller/controller.dart';
import 'package:mana7yaha/model/user_model.dart';

class demandeur extends StatefulWidget {
  const demandeur({Key? key}) : super(key: key);

  @override
  _demandeurState createState() => _demandeurState();
}

class _demandeurState extends State<demandeur> {
  final _formKey = GlobalKey<FormState>();

  final String _selected = '';
  bool _categorySelected = false;
  var dropDownValue, dropDownValPlace;

  final bloodEditingController = TextEditingController();
  String place = '';
  List<String> places = [
    'سعيدة',
    'عين الحجر',
    'عين السخونة',
    'عين سلطان',
    'ذوي ثابت',
    'الحساسنة',
    'معمورة',
    ' مولاي لعربي',
    'أولاد براهيم',
    'أولاد خالد',
    'سيدي أحمد',
    'سيدي أعمر',
    'سيدي بوبكر',
    'تيرسين',
    'يوب',
    'هونة'
  ];
  @override
  Widget build(BuildContext context) {
    final bloodField = DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
        value: dropDownValue,
        hint: const Text("اختر زمرة الدم"),
        items: const [
          DropdownMenuItem(
            child: Text("O+"),
            value: "O+",
          ),
          DropdownMenuItem(
            child: Text("O-"),
            value: "O-",
          ),
          DropdownMenuItem(
            child: Text("A+"),
            value: "A+",
          ),
          DropdownMenuItem(
            child: Text("A-"),
            value: "A-",
          ),
          DropdownMenuItem(
            child: Text("B+"),
            value: "B+",
          ),
          DropdownMenuItem(
            child: Text("B-"),
            value: "B-",
          ),
          DropdownMenuItem(
            child: Text("AB+"),
            value: "AB+",
          ),
          DropdownMenuItem(
            child: Text("AB-"),
            value: "AB-",
          ),
        ],
        validator: (value) {
          if (value == null) {
            return "ادخل زمرة الدم";
          }
          return null;
        },
        onSaved: (value) {
          bloodEditingController.text = value!.toString();
        },
        onChanged: (newValue) {
          setState(() {
            dropDownValue = newValue;
            bloodEditingController.text = newValue.toString();
            _categorySelected = true;
          });
        });
    final placeField = DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
        hint: Text(place.isEmpty ? "اختر البلدية" : place),
        items: places
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            place = value ?? '';
          });
        });

    Widget search() => Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          color: Colors.red.shade800,
          child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async => await Controller.requstOFdonate(context,
                  typeOfBlood: bloodEditingController.text, address: place),
              child: const Text(
                "بحث",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 4.0,
          backgroundColor: Colors.red.shade800,
          leading: IconButton(
            icon: const Icon(
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
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "البحث عن متبرع",
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        color: Colors.red[800],
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 260,
                      child: Image.asset('images/request.png'),
                    ),
                    const SizedBox(height: 50),
                    bloodField,
                    const SizedBox(height: 20),
                    placeField,
                    const SizedBox(height: 20),
                    search(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values

    userModel.place = dropDownValPlace;
    userModel.blood = dropDownValue;
  }
}
