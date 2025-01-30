import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/utils/helper/extensions.dart';
import 'package:weather_app/app/widgets/apptext.dart';

import '../models/models.dart';
import '../provider/weatherProvider.dart';
import '../utils/helper/helpers.dart';
import '../utils/utils.dart';
import 'widget.dart';

 
class TwentyFourHourForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundWhite, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                PhosphorIcon(PhosphorIconsRegular.clock),
                const SizedBox(width: 4.0),
                MedAppText(
                  '24-Hour Forecast',
                  fontSize: 16,
                ),
              ],
            ),
          ),
          Consumer<WeatherProvider>(
            builder: (context, weatherProv, _) {
              if (weatherProv.isLoading) {
                return SizedBox(
                  height: 128.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: 10,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12.0),
                    itemBuilder: (context, index) => CustomShimmer(
                      height: 128.0,
                      width: 64.0,
                    ),
                  ),
                );
              }
              return SizedBox(
                height: 128.0,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherProv.hourlyWeather.length,
                  itemBuilder: (context, index) => HourlyWeatherWidget(
                    index: index,
                    data: weatherProv.hourlyWeather[index],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}

class HourlyWeatherWidget extends StatelessWidget {
  final int index;
  final HourlyWeather data;
  const HourlyWeatherWidget({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124.0,
      child: Column(
        children: [
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return MedAppText(
              weatherProv.isCelsius
                  ? '${data.temp.toStringAsFixed(1)}°'
                  : '${data.temp.toFahrenheit().toStringAsFixed(1)}°',
            );
          }),
          Stack(
            children: [
              Divider(
                thickness: 2.0,
                color: AppColors.primaryBlue,
              ),
              if (index == 0)
                Positioned(
                  top: 2.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 42.0,
            width: 42.0,
            child: Image.asset(
              getWeatherImage(data.weatherCategory),
              fit: BoxFit.cover,
            ),
          ),
          FittedBox(
            child: SmallAppText(
              data.condition?.toTitleCase() ?? '',
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 2.0),
          SmallAppText(
            index == 0 ? 'Now' : DateFormat('hh:mm a').format(data.date),
            fontSize: 12.0,
          )
        ],
      ),
    );
  }
}
