import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/utils/helper/extensions.dart';

import '../models/models.dart';
import '../provider/weatherProvider.dart';
import '../screens/sevenDay.dart';
import '../utils/helper/helpers.dart';
import '../utils/utils.dart';
import 'widget.dart';

class SevenDayForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              PhosphorIcon(PhosphorIconsRegular.calendar),
              const SizedBox(width: 4.0),
              Text(
                '7-Day Forecast',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Consumer<WeatherProvider>(
                builder: (context, weatherProv, _) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                       foregroundColor: AppColors.primaryBlue,
                    ),
                    onPressed: weatherProv.isLoading
                        ? null
                        : () {
                            Navigator.of(context)
                                .pushNamed(SevenDayForecastDetail.routeName);
                          },
                    child: SmallAppText('more details ▶',
                    fontSize: 14.0,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          child: Consumer<WeatherProvider>(
            builder: (context, weatherProv, _) {
              if (weatherProv.isLoading) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  itemBuilder: (context, index) => CustomShimmer(
                    height: 82.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weatherProv.dailyWeather.length,
                itemBuilder: (context, index) {
                  final DailyWeather weather = weatherProv.dailyWeather[index];
                  return Material(
                    borderRadius: BorderRadius.circular(12.0),
                    color: index.isEven ? AppColors.backgroundWhite : Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SevenDayForecastDetail.routeName,
                          arguments: index,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: MedAppText(
                                  index == 0
                                      ? 'Today'
                                      : DateFormat('EEEE').format(weather.date),
                                   maxLines: 1,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.asset(
                                    getWeatherImage(weather.weatherCategory),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                SmallAppText(
                                  weather.weatherCategory,
                                 ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: MedAppText(
                                  weatherProv.isCelsius
                                      ? '${weather.tempMax.toStringAsFixed(0)}°/${weather.tempMin.toStringAsFixed(0)}°'
                                      : '${weather.tempMax.toFahrenheit().toStringAsFixed(0)}°/${weather.tempMin.toFahrenheit().toStringAsFixed(0)}°',
                                 ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
