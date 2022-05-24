import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade800,
          title: const Text("حول من أحياها",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 30),
              Text(
                  " تطبيق تبرع بالدم من أحياها هو مبادرة تسعى إلى تقليص فجوة التواصل بين المتبرعين وبنوك الدم حتى تصبح عملية التبرع بالدم أسهل. يهدف  هذا التطبيق بشكل اساسي الى مساعدة الناس الذين هم بحاجه الى متبرع بالدم على نحو اضطراري او مستعجل. اذ يساعد التطبيق على ايجاد الشخص المناسب الذي يحمل نفس الفصيلة المطلوبة او ارسال طلب اشعار طارئ لجميع المتبرعين المستعدين للتبرع بالدم.",
                  style: TextStyle(
                      fontFamily: 'BalooBhaijaan2',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
