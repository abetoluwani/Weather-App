import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/weatherProvider.dart';
import '../utils/utils.dart';
import 'apptext.dart';
import 'shimmer.dart';

class WeatherInfoHeader extends StatelessWidget {
  static const double boxWidth = 52.0;
  static const double boxHeight = 40.0;
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProv, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            weatherProv.isLoading
                ? Expanded(
                    child: CustomShimmer(
                      height: 48.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FittedBox(
                        //   child: RichText(
                        //     textAlign: TextAlign.start,
                        //     text: TextSpan(
                        //       text: weatherProv.weather.city + ', ',
                        //       style: Text ,
                        //       children: [
                        //         TextSpan(
                        //           text: Country.tryParse(
                        //                   weatherProv.weather.countryCode)
                        //               ?.name,
                        //           style: regularText.copyWith(fontSize: 18.0),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 4.0),
                        FittedBox(
                          child: SmallAppText(
                            DateFormat('EEEE MMM dd, y  hh:mm a')
                                .format(DateTime.now()),
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    ),
                  ),
            const SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: Colors.grey.shade200,
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: weatherProv.isCelsius
                                ? Offset(1.0, 0.0)
                                : Offset(-1.0, 0.0),
                            end: Offset(0.0, 0.0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: weatherProv.isCelsius
                          ? GestureDetector(
                              key: ValueKey<int>(0),
                              child: Row(
                                children: [
                                  Container(
                                    height: boxHeight,
                                    width: boxWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: weatherProv.isLoading
                                          ? Colors.grey
                                          : AppColors.primaryBlue,
                                    ),
                                  ),
                                  Container(
                                    height: boxHeight,
                                    width: boxWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => weatherProv.isLoading
                                  ? null
                                  : weatherProv.switchTempUnit(),
                            )
                          : GestureDetector(
                              key: ValueKey<int>(1),
                              child: Row(
                                children: [
                                  Container(
                                    height: boxHeight,
                                    width: boxWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  Container(
                                    height: boxHeight,
                                    width: boxWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: weatherProv.isLoading
                                          ? Colors.grey
                                          : AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => weatherProv.switchTempUnit(),
                            ),
                    ),
                    IgnorePointer(
                      child: Row(
                        children: [
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            child: SmallAppText(
                              '°C',
                              fontSize: 16,
                              color: weatherProv.isCelsius
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            child: SmallAppText(
                              '°F',
                              fontSize: 16,
                              color: weatherProv.isCelsius
                                  ? Colors.grey.shade600
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
