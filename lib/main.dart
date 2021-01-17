import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc/search/bloc/search_bloc.dart';
import 'package:weather_app/bloc/weather/bloc/weather_bloc.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/ui/bloc_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(create: (context) => ApiService.create(), child: Consumer<ApiService>(
      builder: (context, apiService, child) {
        return MultiBlocProvider(providers: [
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(api: apiService)),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc(api: apiService)),
        ],
          child:  MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocHome(),
          ),
        );
      },
    ),);
  }

}
