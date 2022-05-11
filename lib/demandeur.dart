import 'package:flutter/material.dart';
import 'package:mana7yaha/controller/controller.dart';
import 'package:mana7yaha/user_model.dart';

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
  final placeEditingController = TextEditingController();

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
        value: dropDownValPlace,
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
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
            _categorySelected = true;
          });
        });

    Widget search() => Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          color: Colors.red.shade800,
          child: MaterialButton(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async => Controller.requstOFdonate(context,
                  typeOfBlood: bloodEditingController.text,
                  address: placeEditingController.text),
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
                      Text(
                        "البحث عن متبرع",
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          color: Colors.red[800],
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 50),
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
