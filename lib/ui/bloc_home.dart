import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/bloc/weather/bloc/weather_bloc.dart';
import 'package:weather_app/ui/search.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/helper.dart';
import 'package:weather_app/utils/routeFade.dart';

class BlocHome extends StatefulWidget {
  int cityCode;

  BlocHome({this.cityCode = 1015662});
  @override
  _BlocHomeState createState() => _BlocHomeState();
}

class _BlocHomeState extends State<BlocHome> {

  final newFormat = DateFormat("dd/MM/yy H:m:s");

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
      weatherBloc..add(FetchWeather(cityCode: widget.cityCode));

      return Scaffold(
        body: SafeArea(
          child: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state){
                        if(state is LoadingWeatherState){
                          return Center(
                              child: CircularProgressIndicator(),
                          );
                        }

                        if(state is LoadedWeatherState) {
                          return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/${Helper.mapStringToImage(state.weathersModel.weathers[0].weatherStateAbbr)}.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Container(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.weathersModel.weathers[0].weatherStateName}',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 50),
                                  ),
                                ),
                                Text(
                                  '${state.weathersModel.weathers[0].theTemp.toInt() } °C',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 30),
                                  ),
                                ),
                                SizedBox(height: 50,),
                                SvgPicture.asset('images/icons/${Helper.mapStringToImage(state.weathersModel.weathers[0].weatherStateAbbr)}.svg', color: Colors.white,
                                  height: 100,width: 100,),
                                SizedBox(height: 50,),
                                Text(
                                  '${state.weathersModel.title}',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 50),
                                  ),
                                ),

                                SizedBox(height: 20,),
                                Text(
                                  'Updated: ${newFormat.format(DateTime.parse(state.weathersModel.weathers[0].created))}',
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 10),
                                  ),
                                ),
                                SizedBox(height: 80,),

                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white38,
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(FadeRoute(page: SearchPage()));
                                    },
                                    icon: Icon(Icons.search, color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          )
                              ],
                            ),
                          );
                        }

                        return Text("hello ");
          },),
        ),
      );

  }
}
