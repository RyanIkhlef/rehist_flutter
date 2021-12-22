import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rehist/services/event_service.dart';

class MapsEventsPage extends StatefulWidget {
  const MapsEventsPage({Key? key}) : super(key: key);

  static const String routeName = '/mapsEvents';

  static const LatLng showLocation = LatLng(48.84861, 2.36652);

  @override
  State<MapsEventsPage> createState() => _MapsEventsPageState();
}

class _MapsEventsPageState extends State<MapsEventsPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(48.84861, 2.36652);

  final MapType _currentMapType = MapType.normal;

  Set<Marker> markers = <Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text('Evenements'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Center(
                child: FutureBuilder(
                    future: EventService.getEvents(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Set<Marker> markers = <Marker>{};
                      for (var data in snapshot.data) {
                        markers.add(Marker( //add second marker
                          markerId: MarkerId(MapsEventsPage.showLocation.toString()),
                          position: LatLng(data['long'], data['lat']),
                          //position of marker
                          infoWindow: InfoWindow(title: data['title'],
                              snippet: data['date']),
                          icon: BitmapDescriptor.defaultMarker,
                        ));
                      }
                      return GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 5.0,),
                          mapType: _currentMapType,
                          markers: markers
                      );
                    }
                )
            )
    );
  }
}