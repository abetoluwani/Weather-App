import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/utils/helper/extensions.dart';

import '../provider/weatherProvider.dart';
import '../utils/helper/helpers.dart';
import 'widget.dart';
 
class MainWeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      if (weatherProv.isLoading) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomShimmer(
                height: 148.0,
                width: 148.0,
              ),
            ),
            const SizedBox(width: 16.0),
            CustomShimmer(
              height: 148.0,
              width: 148.0,
            ),
          ],
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: BigAppText(
                            weatherProv.isCelsius
                                ? weatherProv.weather.temp.toStringAsFixed(1)
                                : weatherProv.weather.temp
                                    .toFahrenheit()
                                    .toStringAsFixed(1),
                            fontSize: 86,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MedAppText(
                            weatherProv.measurementUnit,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmallAppText(
                    weatherProv.weather.description.toTitleCase(),
                    fontSize: 16,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 148.0,
              width: 148.0,
              child: Image.asset(
                getWeatherImage(weatherProv.weather.weatherCategory),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    });
  }
}
