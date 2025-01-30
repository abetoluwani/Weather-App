// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/utils/helper/extensions.dart'; 
import '../provider/weatherProvider.dart';
import '../utils/helper/helpers.dart';
import '../utils/utils.dart';
import 'widget.dart';

class MainWeatherDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      if (weatherProv.isLoading) {
        return CustomShimmer(
          height: 132.0,
          borderRadius: BorderRadius.circular(16.0),
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    DetailInfoTile(
                        icon: PhosphorIcon(
                          PhosphorIconsRegular.thermometerSimple,
                          color: Colors.white,
                        ),
                        title: 'Feels Like',
                        data: weatherProv.isCelsius
                            ? '${weatherProv.weather.feelsLike.toStringAsFixed(1)}°'
                            : '${weatherProv.weather.feelsLike.toFahrenheit().toStringAsFixed(1)}°'),
                    VerticalDivider(
                      thickness: 1.0,
                      indent: 4.0,
                      endIndent: 4.0,
                      color: AppColors.backgroundBlue,
                    ),
                    DetailInfoTile(
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.drop,
                        color: Colors.white,
                      ),
                      title: 'Precipitation',
                      data:
                          '${weatherProv.additionalWeatherData.precipitation}%',
                    ),
                    VerticalDivider(
                      thickness: 1.0,
                      indent: 4.0,
                      endIndent: 4.0,
                      color: AppColors.backgroundBlue,
                    ),
                    DetailInfoTile(
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.sun,
                        color: Colors.white,
                      ),
                      title: 'UV Index',
                      data: uviValueToString(
                        weatherProv.additionalWeatherData.uvi,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: AppColors.backgroundBlue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    DetailInfoTile(
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.wind,
                        color: Colors.white,
                      ),
                      title: 'Wind',
                      data: '${weatherProv.weather.windSpeed} m/s',
                    ),
                    VerticalDivider(
                      thickness: 1.0,
                      indent: 4.0,
                      endIndent: 4.0,
                      color: AppColors.backgroundBlue,
                    ),
                    DetailInfoTile(
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.dropHalfBottom,
                        color: Colors.white,
                      ),
                      title: 'Humidity',
                      data: '${weatherProv.weather.humidity}%',
                    ),
                    VerticalDivider(
                      thickness: 1.0,
                      indent: 4.0,
                      endIndent: 4.0,
                      color: AppColors.backgroundBlue,
                    ),
                    DetailInfoTile(
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.cloud,
                        color: Colors.white,
                      ),
                      title: 'Cloudiness',
                      data: '${weatherProv.additionalWeatherData.clouds}%',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DetailInfoTile extends StatelessWidget {
  final String title;
  final String data;
  final Widget icon;
  const DetailInfoTile({
    Key? key,
    required this.title,
    required this.data,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: AppColors.primaryBlue, child: icon),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: MedAppText(title, color: Colors.white)),
                FittedBox(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 1.0),
                    child: MedAppText(
                      data,
                      color: Colors.white,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
