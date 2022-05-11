import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mana7yaha/controller/controller.dart';

import '../../model/fetch_requests.dart';
import 'add_comment.dart';

class FetchBlood extends StatelessWidget {
  const FetchBlood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اليحث عن متلقين'),
      ),
      body: FutureBuilder<List<FetchRequestsModel>>(
        future: Controller.fetchRequests(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(child: Text('لا يوجد متلقين'));
          } else {
            return snapshot.data!.isEmpty
                ? const Center(child: Text('لا يوجد متلقين'))
                : ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      FetchRequestsModel data = snapshot.data![index];
                      return FetchBloodCard(
                        address: data.address,
                        blood: data.bloodType,
                        date: data.date,
                        id: data.id,
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class FetchBloodCard extends StatefulWidget {
  FetchBloodCard({Key? key, this.address, this.blood, this.date, this.id})
      : super(key: key);
  String? address, blood, date, id;

  @override
  State<FetchBloodCard> createState() => _FetchBloodCardState();
}

class _FetchBloodCardState extends State<FetchBloodCard> {
  late DateTime myDate;
  late String formatted;

  @override
  void initState() {
    super.initState();
    myDate = DateTime.parse(widget.date ?? '');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(myDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 22,
        child: ListTile(
          onTap: () =>
              Controller.navigatorGO(AddComment(id: widget.id), context),
          leading: Text('فئه الدم: ${widget.blood} '),
          subtitle: Text('العنوان: ${widget.address}'),
          title: Text('تاريخ الطلب: ${formatted}'),
        ));
  }
}
