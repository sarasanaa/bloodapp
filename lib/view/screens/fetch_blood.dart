import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mana7yaha/controller/controller.dart';

import '../../model/fetch_requests.dart';
import 'add_comment.dart';

class FetchBlood extends StatelessWidget {
  const FetchBlood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('طلبات التبرع'),
          centerTitle: true,
          backgroundColor: Colors.red.shade800,
        ),
        body: FutureBuilder<List<FetchRequestsModel>>(
          future: Controller.fetchRequests(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData == false) {
              return const Center(child: Text('لا يوجد طلبات'));
            } else {
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('لا يوجد طلبات'))
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
    final intl.DateFormat formatter = intl.DateFormat('yyyy-MM-dd');
    formatted = formatter.format(myDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 22,
        child: ListTile(
          onTap: () =>
              Controller.navigatorGO(AddComment(id: widget.id), context),
          leading: CircleAvatar(
            child: Text(
              '${widget.blood}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.redAccent,
          ),
          title: Text(
            'البلدية: ${widget.address}',
            style: const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            'تاريخ الطلب: $formatted',
            style: const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ));
  }
}
