import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather_response/weather_response.dart';
import 'package:weather_app/ui/screens/weather_details_screen.dart';
import "package:weather_app/extensions/string_extension.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextStyle textStyle() => const TextStyle(fontSize: 18, color: Colors.white);
  final TextEditingController _controller = TextEditingController();
  String city = '';
  @override
  void initState() {
    super.initState();
    city = 'Dubai';
    WeatherBloc.instance.init();
    WeatherBloc.instance
        .getWeather(appid: '8925480114759bf525fdade7a857b52c', city: city.isEmpty ? 'dubai' : city, fromApi: true);
  }

  @override
  void dispose() {
    super.dispose();
    WeatherBloc.instance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                WeatherBloc.instance.getWeather(appid: '8925480114759bf525fdade7a857b52c', city: value, fromApi: true);
                city = value;
                _controller.text = '';
              },
              style: const TextStyle(
                color: Colors.black,
              ),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
                fillColor: Colors.white.withOpacity(0.5),
                filled: true,
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintStyle: const TextStyle(color: Colors.black),
                hintText: 'Search'.toUpperCase(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<WeatherResponse?>(
          stream: WeatherBloc.instance.weatherResponse,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/weather.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: Text(
                    "Couldn't Find City: $city",
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  )));
            } else if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/weather.jpg',
                      ),
                      fit: BoxFit.cover),
                ),
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: WeatherBloc.instance.dateList!.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.transparent,
                      elevation: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeatherDetailsScreen(
                                city: city,
                                index: index.toString(),
                                dayWeather: WeatherBloc.instance
                                    .getDayWeather(WeatherBloc.instance.tempList!.value[index].dtTxt),
                                date: '${WeatherBloc.instance.dateList!.value[index]}',
                              ),
                            ),
                          );
                        },
                        title: Center(
                          child: WeatherBloc.instance.dateList!.hasValue == true
                              ? Hero(
                                  tag: 'date-${WeatherBloc.instance.dateList!.value[index]}',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text('${WeatherBloc.instance.dateList!.value[index]}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
                                  ),
                                )
                              : const Text(''),
                        ),
                        subtitle: Row(
                          children: [
                            const Spacer(),
                            snapshot.data != null
                                ? Expanded(
                                    child: Text(
                                        '${(WeatherBloc.instance.tempList!.value[index].main.temp - 273.15).round().toString()}\u2103 ',
                                      style: textStyle()),
                                  )
                                : const Text(''),
                            Expanded(
                              child: Hero(
                                  tag: city + index.toString(),
                                  child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(city.capitalize(), style: textStyle()))),
                            ),
                            snapshot.data != null
                                ? Expanded(
                                    child: Text(WeatherBloc.instance.tempList!.value[index].weather[0].main,
                                        style: textStyle()))
                                : const Text(''),
                            const Spacer(),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/weather.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )));
            }
          }),
    );
  }
}
