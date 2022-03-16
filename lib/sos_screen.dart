import 'package:camera/camera.dart';
import 'package:client_side/camera_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'colors.dart';
import 'texts.dart';
import 'map_class.dart';
import 'dart:async';
import 'package:camera/camera.dart';


class Sos extends StatefulWidget {
  const Sos({Key? key}) : super(key: key);

  @override
  _SosState createState() => _SosState();
}

class _SosState extends State<Sos> {
  //static MapController _mapController;
  late final MapController _mapController;

  void initState() {
    // intialize the controllers
    _mapController = MapController();
    super.initState();
  }

  void raload(Position position){
    setState(() {
      map_class.lat=position.latitude;
      map_class.long=position.longitude;
      app_colors.app_bar_background=Colors.green;

    });



  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async{
    print("ffff");
    List<Placemark> placemark= await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);



  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(my_texts.CitySafty, style: TextStyle(color: app_colors.city_safty),),
        backgroundColor: app_colors.app_bar_background,
        elevation: 10,
        actions: [
          IconButton(
            onPressed:()=> {},
            icon: Icon(Icons.arrow_drop_down_circle),
          ),
        ],
      ),
      body:Container(
        child: Stack(
        children: [
          Container(
            child: FlutterMap(
              mapController: _mapController,

              options: MapOptions(
                center: LatLng(map_class.lat,map_class.long),
                zoom: 13.0,


              ),

              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/citysafty/ckzr6bk8m007h15qpnoihdu94/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2l0eXNhZnR5IiwiYSI6ImNrenI1YnhjYjBlMm4ycHBreGR6aWNscXgifQ.tB3OAhmkkVmY4ztI_cwG9Q",
                  additionalOptions: {
                    'accessToken':'pk.eyJ1IjoiY2l0eXNhZnR5IiwiYSI6ImNrenI1YnhjYjBlMm4ycHBreGR6aWNscXgifQ.tB3OAhmkkVmY4ztI_cwG9Q',
                    'id': 'mapbox.mapbox-streets-v8'

                  },
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(map_class.lat, map_class.long),
                        builder:(_){
                          return Icon(Icons.location_on,size: 50.0,color: Colors.red);
                        }
                    ),
                  ],
                ),
              ],

            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom:10),
            child:
            Column(
              children: [
                SizedBox(height: 560,),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          boxShadow:[
                            BoxShadow(
                                color: app_colors.buttom_shadow,
                                blurRadius: 20,
                                offset: Offset(8,5)

                            ),
                            BoxShadow(
                                color: app_colors.buttom_shadow,
                                blurRadius: 20,
                                offset: Offset(-8,-5)

                            ),
                          ]
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>camera_page()),);
                        },
                        child: Icon(Icons.camera_alt,size: 40.0,),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200.0)),
                          primary: app_colors.cmera_button,
                          minimumSize: Size(70.0, 70.0),

                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          )





        ],

      ),) ,
      floatingActionButton:
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            boxShadow:[
        BoxShadow(
        color: app_colors.buttom_shadow,
            blurRadius: 20,
            offset: Offset(8,5)

        ),
        BoxShadow(
            color: app_colors.buttom_shadow,
            blurRadius: 20,
            offset: Offset(-8,-5)

        ),
            ]
        ),

        child: SizedBox(height: 100.0,
          width: 100.0,
          child:

          FloatingActionButton(
            //child: Icon(Icons.ac_unit),
            child: Text("SOS"),
            backgroundColor: Colors.red,


            onPressed: () async {
              Position position=await _determinePosition();
              //await GetAddressFromLatLong(position);
              print("hello2");
              raload(position);
              _mapController.move(LatLng(map_class.lat,map_class.long), 13.0);
            },
          ),

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
