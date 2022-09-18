import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final double lat;
  final double long;
  const MapPage({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Marker> _markers = <Marker>{};
  @override
  void initState() {
    _markers.add(Marker(
        markerId: const MarkerId("marker-0"),
        position: LatLng(widget.lat, widget.long)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.location_title.tr(),
      ),
      body: GoogleMap(
        markers: _markers,
        initialCameraPosition:
            CameraPosition(target: LatLng(widget.lat, widget.long), zoom: 13),
        myLocationButtonEnabled: false,
      ),
    );
  }
}
