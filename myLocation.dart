import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/userCurrentLocation.dart';

class Mylocation extends StatefulWidget {
  const Mylocation({super.key});

  @override
  State<Mylocation> createState() => _MylocationState();
}

class _MylocationState extends State<Mylocation> {

 late String lat;
  late String long;

  Position? position;
  static const LatLng _currentLocation= LatLng(37.4180933, -122.1025433);
  static const LatLng _previousLocation= LatLng(37.43317963130936, -122.11738765239717);
  
  late GoogleMapController? googleMapController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getCurrentLocation().then((value){

    //});
    listenCurrentLocation();
  }

  Future<void> listenCurrentLocation() async {

    final isGrand=await isLocationPermissionGrand();
    print('isGrand:$isGrand');
    if(isGrand){
      final isServicesEnable= await checkGPSServicesEnable();
      if(isServicesEnable){
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
            //timeLimit: Duration(seconds: 3),
            distanceFilter: 100,
            accuracy: LocationAccuracy.bestForNavigation,
          )
        ).listen((pos){
          print(pos);
        });
      }else{
        Geolocator.openLocationSettings();
      }
    } else{
      final result=await requestLocationPermission();
      if(result){
        getCurrentLocation();
      }else{
        Geolocator.openAppSettings();
      }
    }

  }


  Future<void> getCurrentLocation() async {

    final isGrand=await isLocationPermissionGrand();
    print('isGrand:$isGrand');
    if(isGrand){
      final isServicesEnable= await checkGPSServicesEnable();
      if(isServicesEnable){
       Position Getposition=await Geolocator.getCurrentPosition();
       position=Getposition;
       print(position);
       lat=position!.latitude.toString();
       long=position!.longitude.toString();
     // lat=double.tryParse(position!.latitude.toString());
     // long=double.tryParse(position!.longitude.toString());
       print(position);
       setState(() {});
      }else{
        Geolocator.openLocationSettings();
      }
    } else{
      final result=await requestLocationPermission();
      if(result){
        getCurrentLocation();
      }else{
        Geolocator.openAppSettings();
      }
    }

  }
  Future<bool> isLocationPermissionGrand() async{
    LocationPermission permission= await Geolocator.checkPermission();
    if(permission == LocationPermission.always || permission==LocationPermission.whileInUse){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> requestLocationPermission() async{
    LocationPermission permission= await Geolocator.requestPermission();
    if(permission == LocationPermission.always || permission==LocationPermission.whileInUse){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> checkGPSServicesEnable() async{
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Location'),
      ),
     body: GoogleMap(
       mapType: MapType.normal,
       zoomControlsEnabled: true,
       zoomGesturesEnabled: true,
       onMapCreated: (GoogleMapController controller){
         googleMapController=controller;
       },
        initialCameraPosition:
        CameraPosition(
            target: _currentLocation,
            zoom: 16
        ),
       onTap: (LatLng? latLng){
         print(latLng);
       },
       markers: <Marker>{
          Marker(//_currentLocation,
            markerId: MarkerId('My_Location'),
            position: _currentLocation,
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: "My Location")
          ),
         Marker(
           markerId: MarkerId('Previous_Location'),
           position: _previousLocation,
           icon: BitmapDescriptor.defaultMarker,
           infoWindow: InfoWindow(title: "Previous Location")
         ),

       },
       polylines: <Polyline>{
         Polyline(polylineId: PolylineId('random'),
             color: Colors.blue,
             width: 8,
             points: <LatLng>[

               LatLng(37.4180933, -122.1025433),
               LatLng(37.43317963130936, -122.11738765239717),
              // LatLng(24.37704357698618, 88.57633139938116)
             ]

         )
       },
      ),
       // Column(
       //   children: [
       //    Center(
       //       child: Text('My Current Location $position'),
       //      ),
       //      ElevatedButton(
       //        onPressed: () {
       //          getCurrentLocation().then(val);
       //        },
       //        child: Text('Get Current Location'),
       //     ),
       //   ],
       //
       //  ),
    //




    );
  }



}

