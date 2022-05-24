import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'Data.dart';

class NearPlaces extends StatefulWidget {
  const NearPlaces({Key? key}) : super(key: key);

  @override
  _NearPlacesState createState() => _NearPlacesState();
}

class _NearPlacesState extends State<NearPlaces> {
  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  Data data = Data();

  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    for (int i = 0; i < data.allstores.length; i++) {
      double storelat = data.allstores[i]['lat'];
      double storelng = data.allstores[i]['lng'];

      distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
        storelat,
        storelng,
      );
      var distance = distanceImMeter?.round().toInt();

      data.allstores[i]['distance'] = (distance! / 100);
      setState(() {});
    }
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.shade800,
        title: const Text("الأماكن الأقرب اليك"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: GridView.builder(
            itemCount: data.allstores.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
                height: height * 0.9,
                width: width * 0.3,
                child: Column(
                  children: [
                    Text(
                      data.allstores[index]['name'],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'BalooBhaijaan2',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on),
                        Text(
                          "${data.allstores[index]['distance'].round()}  KM  ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
