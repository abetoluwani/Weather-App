import 'package:flutter/material.dart';
 import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app/utils/theme/colors.dart';
import 'package:weather_app/app/widgets/widget.dart';

import '../provider/weatherProvider.dart';
 
class RequestErrorDisplay extends StatelessWidget {
  const RequestErrorDisplay({Key? key}) : super(key: key);

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
            child: Image.asset('assets/images/requestError.png'),
          ),
          Center(
            child: SmallAppText(
              'Request Error',
              color: AppColors.primaryBlue,
             ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: SmallAppText(
              'Request error, please check your internet connection',
              alignment: TextAlign.center,
              color: AppColors.grey200,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: AppElevatedButton(
                title: 'Return Home',
                onPressed: weatherProv.isLoading
                    ? null
                    : () async {
                        await weatherProv.getWeatherData(
                          context,
                          notify: true,
                        );
                      },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class SearchErrorDisplay extends StatelessWidget {
  const SearchErrorDisplay({
    Key? key,
    required this.fsc,
  }) : super(key: key);

  final FloatingSearchBarController fsc;

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
            child: Image.asset('assets/images/searchError.png'),
          ),
          Center(
            child: SmallAppText(
              'Search Error',
              alignment: TextAlign.center,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: SmallAppText(
              'Unable to find "${fsc.query}", check for typo or check your internet connection',
              alignment: TextAlign.center,
              color: AppColors.grey200,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: AppElevatedButton(
                title: 'Return Home',
                onPressed: weatherProv.isLoading
                    ? null
                    : () async {
                        await weatherProv.getWeatherData(
                          context,
                          notify: true,
                        );
                      },
              ),
            );
          }),
        ],
      ),
    );
  }
}
