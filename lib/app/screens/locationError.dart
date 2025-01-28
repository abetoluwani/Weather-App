import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../provider/weatherProvider.dart';
import '../utils/utils.dart';
import '../widgets/widget.dart';

class LocationPermissionErrorDisplay extends StatelessWidget {
  const LocationPermissionErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width,
                minWidth: 100,
                maxHeight: MediaQuery.sizeOf(context).height / 3,
              ),
              child: Image.asset('assets/images/locError.png'),
            ),
            Center(
              child: SmallAppText(
                'Location Permission Error',
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 4.0),
            Center(
              child: SmallAppText(
                weatherProv.locationPermission ==
                        LocationPermission.deniedForever
                    ? 'Location permissions are permanently denied, Please enable manually from app settings and restart the app'
                    : 'Location permission not granted, please check your location permission',
                color: AppColors.grey200,
                alignment: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: weatherProv.isLoading
                        ? null
                        : () async {
                            if (weatherProv.locationPermission ==
                                LocationPermission.deniedForever) {
                              await Geolocator.openAppSettings();
                            } else {
                              weatherProv.getWeatherData(context, notify: true);
                            }
                          },
                    child: weatherProv.isLoading
                        ? const SizedBox(
                            width: 16.0,
                            height: 16.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            weatherProv.locationPermission ==
                                    LocationPermission.deniedForever
                                ? 'Open App Settings'
                                : 'Request Permission',
                          ),
                  ),
                  const SizedBox(height: 4.0),
                  if (weatherProv.locationPermission ==
                      LocationPermission.deniedForever)
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue),
                      onPressed: weatherProv.isLoading
                          ? null
                          : () =>
                              weatherProv.getWeatherData(context, notify: true),
                      child: Text('Restart'),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class LocationServiceErrorDisplay extends StatefulWidget {
  const LocationServiceErrorDisplay({Key? key}) : super(key: key);

  @override
  State<LocationServiceErrorDisplay> createState() =>
      _LocationServiceErrorDisplayState();
}

class _LocationServiceErrorDisplayState
    extends State<LocationServiceErrorDisplay> {
  late StreamSubscription<ServiceStatus> serviceStatusStream;

  @override
  void initState() {
    super.initState();
    serviceStatusStream = Geolocator.getServiceStatusStream().listen((_) {});
    serviceStatusStream.onData((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        print('enabled');
        Provider.of<WeatherProvider>(context, listen: false)
            .getWeatherData(context);
      }
    });
  }

  @override
  void dispose() {
    serviceStatusStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width,
              minWidth: 100,
              maxHeight: MediaQuery.sizeOf(context).height / 3,
            ),
            child: Image.asset('assets/images/locError.png'),
          ),
          Center(
            child: SmallAppText(
              'Location Service Disabled',
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: SmallAppText(
              'Your device location service is disabled, please turn it on before continuing',
              alignment: TextAlign.center,
              color: AppColors.grey200,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: AppElevatedButton(
                title: 'Turn On Service',
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
