import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '././bloc/WeatherBloc.dart';
import '././bloc/WeatherEvent.dart';
import '././bloc/WeatherState.dart';
import './data/Constants.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of(context);
    weatherBloc.add(WeatherEvent.FETCH_WEATHER);
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.cityNmae),
      ),
      body: Center(child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is SuccessWeatherState)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${state.weatherResponse!.location!.name}'),
                Text('${state.weatherResponse!.current!.temperature}'),
                Image.network(
                    '${state.weatherResponse!.current!.weather_icons![0]}'),
                Text(
                    '${state.weatherResponse!.current!.weather_descriptions![0]}'),
              ],
            );
          else if (state is ErrorWeatherState) {
            return Text('${state.baseException!.message}');
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}