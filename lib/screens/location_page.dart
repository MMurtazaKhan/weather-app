import 'package:climate/screens/city_screen.dart';
import 'package:climate/services/weather.dart';
import 'package:climate/utilties/constants.dart';
import 'package:flutter/material.dart';



class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}
  WeatherModel weather_model = WeatherModel();
  var icon;
  int temperature;
  String weatherMessage;
  var city;

class _LocationScreenState extends State<LocationScreen> {
  void updateUI(dynamic weatherData){
    setState(() { 
      if(weatherData == null){
        icon = "Error";
        temperature =0;
        weatherMessage = "Unable to find the weather";
        city = "";
        return;
      }      
       var id = weatherData['weather'][0]['id'];
       icon = weather_model.getWeatherIcon(id);
       double temp = weatherData['main']['temp'];
       temperature = temp.toInt();
       weatherMessage =  weather_model.getMessage(temperature);
       city = weatherData['name'];
        });
  }

  @override
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    var kTempTextStyle2 = kTempTextStyle;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather_model.getWeatherLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if(typedName != null) {
                        var weatherData = await weather_model.getWeatherCity(cityName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temperature.toString(),
                      style: kTempTextStyle2,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$temperature in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}