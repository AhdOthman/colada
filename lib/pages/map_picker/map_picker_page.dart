import 'dart:async';
import 'dart:developer';

import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/current_location.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:auto_route/auto_route.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({Key? key}) : super(key: key);

  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(24.774265, 46.738586),
    zoom: 25.4746,
  );
  var textController = TextEditingController();

  final positionProvider = FutureProvider<Position>((ref) async {
    final position = await CurrentLocation.fetch();
    return position;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      extendBodyBehindAppBar: true,
      body: Consumer(builder: (context, ref, child) {
        final position = ref.watch(positionProvider);
        return position.when(
            data: (pos) => Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    MapPicker(
                      iconWidget: SvgPicture.asset(
                        "assets/icons/location_icon.svg",
                        height: 60,
                        color: AppColors.primaryColor,
                      ),
                      //add map picker controller
                      mapPickerController: mapPickerController,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        // hide location button
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        //  camera position
                        initialCameraPosition: CameraPosition(
                          target: LatLng(pos.latitude, pos.longitude),
                          zoom: 11,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMoveStarted: () {
                          // notify map is moving
                          mapPickerController.mapMoving!();
                          // textController.text = '';
                        },
                        onCameraMove: (cameraPosition) {
                          this.cameraPosition = cameraPosition;
                        },
                        onCameraIdle: () async {
                          // notify map stopped moving
                          mapPickerController.mapFinishedMoving!();
                          //get address name from camera position
                          List<Placemark> placeMarks =
                              await placemarkFromCoordinates(
                            cameraPosition.target.latitude,
                            cameraPosition.target.longitude,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: Constants.padding * 2,
                      left: Constants.padding * 2,
                      right: Constants.padding * 2,
                      child: ButtonWidget(
                        title: "Submit",
                        onPressed: () async {
                          List<Placemark> placeMarks =
                              await placemarkFromCoordinates(
                            cameraPosition.target.latitude,
                            cameraPosition.target.longitude,
                          );

                          context.router.pop([
                            UserLocationModel(
                                lat: cameraPosition.target.latitude.toString(),
                                lng: cameraPosition.target.longitude.toString(),
                                address: placeMarks.first.street,
                                city: placeMarks.first.locality)
                          ]);
                        },
                      ),
                    )
                  ],
                ),
            loading: () => const LoaderWidget(),
            error: (Object error, StackTrace? stackTrace) {
              log("error: $error", name: "MapPickerPage");
              return const Center(
                  child: TextWidget('Please make sure the location enabled'));
            });
      }),
    );
  }
}
