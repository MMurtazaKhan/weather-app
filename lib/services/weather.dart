import 'package:climate/services/location.dart';
import 'package:climate/services/networking.dart';

const apiKey = '640b12fcd822753c3923cc6893c4024c';
const apiData = 'https://api.openweathermap.org/data/2.5/weather';
Location location = Location();
double latitude = location.latitude;
double longitude = location.longitude;
class WeatherModel {

  Future<dynamic> getWeatherCity(String cityName) async {
    String URL = '$apiData?q=$cityName&appid=$apiKey&units=metric';
    myNetwork network = myNetwork(URL);
    var weatherData = await network.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherLocation() async {
  await location.getCurrentLocation();
  
  myNetwork network = myNetwork('$apiData?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
  var weatherData = await network.getData();
  return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}