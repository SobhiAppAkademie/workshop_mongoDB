import 'dart:convert';
import 'package:http/http.dart';

/// Hole aktuelle Wetter-Daten aus einer API

/// Der Status für die Wettervorhersage
enum WeatherStatus { Normal, Rain, Showers, Snowfall }

/// Angepasste Klasse an den Response von der Wetter-API
class WeatherData {
  final int temperatur;
  final WeatherStatus weatherStatus;

  factory WeatherData.fromJSON(Map<String, dynamic> json) {
    WeatherStatus status = WeatherStatus.Normal;
    bool rain = json["rain"] > 0;
    bool showers = json["showers"] > 0;
    bool snowfall = json["snowfall"] > 0;

    if (rain) status = WeatherStatus.Rain;
    if (showers) status = WeatherStatus.Showers;
    if (snowfall) status = WeatherStatus.Snowfall;

    return WeatherData(
        temperatur: json["temperature_2m"].toInt(), weatherStatus: status);
  }

  WeatherData({required this.temperatur, required this.weatherStatus});
}

class WeatherRepository {
  /// Wetter-API: Open-Meteo: https://open-meteo.com/en/docs
  static const _apiUrl =
      "https://api.open-meteo.com/v1/forecast?latitude=52.4245&longitude=10.7815&current=temperature_2m,rain,showers,snowfall";

  static WeatherData? weatherData;

  static Future<void> getCurrentWeather() async {
    final Response response = await get(Uri.parse(_apiUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      weatherData = WeatherData.fromJSON(json.decode(response.body)["current"]);
    } else {
      /// Simulieren Daten, wenn die API Anfrage nicht erfolgreich war.
      weatherData =
          WeatherData(temperatur: 7, weatherStatus: WeatherStatus.Normal);
    }
  }
}
