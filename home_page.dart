import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import 'const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Coimbatore").then((w) {
      setState(() {
        _weather=w;
      });

    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),

    );
  }

  Widget _buildUI(){
    if(_weather==null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.05,
          ),
          _dateTimeInfo(),
      SizedBox(
        height: MediaQuery.sizeOf(context).height*0.05,),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.05,),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.05,),
          _extraInfo(),
        ],
      ),
    );

}
Widget _locationHeader(){
    return Text(_weather?.areaName ??"",style:TextStyle(fontSize: 20,fontWeight:FontWeight.w500
    ) ,);
}
Widget _dateTimeInfo(){
    DateTime now =_weather!.date!;
    return Column(
      children: [
        Text(DateFormat("hh:mm a").format(now),style: TextStyle(fontSize: 35),),
        SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
              style: TextStyle(fontWeight:FontWeight.w700 ),),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("${DateFormat("dd.M.yyyy").format(now)}",
                style: TextStyle(fontWeight:FontWeight.w700 ),),
            ),


          ],
        )
      ],
    );
}
Widget _weatherIcon()
{
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        height: MediaQuery.sizeOf(context).height*0.20,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
      ),
      Text(_weather?.weatherDescription ??"",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15 ),),
    ],

  );

}
Widget _currentTemp()
{
  return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
  style: TextStyle(color: Colors.black,fontSize: 70,fontWeight: FontWeight.w500),);
}
Widget _extraInfo(){
    return Container(
      height: MediaQuery.sizeOf(context).height*0.15,
      width: MediaQuery.sizeOf(context).width*0.80,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(8)
      ),
        padding: const EdgeInsets.all(8.0),
        child: Column( mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Max :${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                style: TextStyle(color: Colors.white,fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Min :${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white,fontSize: 15),),
                )
              ],
            ), Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("WindSpeed :${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                  style: TextStyle(color: Colors.white,fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Humidity :${_weather?.humidity?.toStringAsFixed(0)}°C",
                    style: TextStyle(color: Colors.white,fontSize: 15),),
                )
              ],
            )
          ],
        ),
    );
}
}
