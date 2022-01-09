
import 'package:climate/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_page.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
  
}


// void getWeather() async {
//   http.Response response = await http.get(Uri.parse(
//       'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'));
//   var data = response.body;
//   var decodedData = jsonDecode(data);
//   var id = decodedData['weather'][0]['id'];
//   var temp = decodedData['main']['temp'];
//   var city = decodedData['name'];
//   print(" $id \n $temp \n $city");
// }

class _LoadingScreenState extends State<LoadingScreen> {

  @override
   void initState(){
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getWeatherLocation();

  Navigator.push(context, MaterialPageRoute(builder: (context){
    return LocationScreen(locationWeather: weatherData,);
  }));
}
  @override
  
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(child:
            SpinKitRotatingCircle(
            color: Colors.white,
            size: 100.0,

       ),
      ),
    );
  }
}
