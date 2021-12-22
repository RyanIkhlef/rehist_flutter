import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rehist/services/association_service.dart';

class MapsAssociationsPage extends StatefulWidget {
  const MapsAssociationsPage({Key? key}) : super(key: key);

  static const String routeName = '/mapsAssociations';

  static const LatLng showLocation = LatLng(48.84861, 2.36652);

  @override
  State<MapsAssociationsPage> createState() => _MapsAssociationsPageState();
}

class _MapsAssociationsPageState extends State<MapsAssociationsPage> {
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
              title: const Text('Associations'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Center(
                child: FutureBuilder(
                    future: AssociationService.getAssociations(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Set<Marker> markers = <Marker>{};
                      for (var data in snapshot.data) {
                        markers.add(Marker( //add second marker
                          markerId: MarkerId(MapsAssociationsPage.showLocation.toString()),
                          position: LatLng(data['long'], data['lat']),
                          //position of marker
                          infoWindow: InfoWindow(title: data['title'],
                              snippet: data['description']),
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