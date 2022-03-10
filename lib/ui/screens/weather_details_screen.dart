import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_quiz_app/models/weather_object/weather_object.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String date;
  final List<WeatherObject> dayWeather;

  const WeatherDetailsScreen({
    Key? key,
    required this.date,
    required this.dayWeather,
  }) : super(key: key);

  @override
  _WeatherDetailsScreenState createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  int currentPage = 0;
  TextStyle textStyle() => const TextStyle(fontSize: 18, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    String bgImg = '';

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: (20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.dayWeather.length,
                    (index) => buildDot(index: index),
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: widget.dayWeather.length,
                  itemBuilder: (context, i) {
                    if (widget.dayWeather[i].weather[0].main == 'Clear') {
                      bgImg = 'assets/images/clear.jpg';
                    } else if (widget.dayWeather[i].weather[0].main == 'Clouds') {
                      bgImg = 'assets/images/cloudy.jpg';
                    } else if (widget.dayWeather[i].weather[0].main == 'Rain') {
                      bgImg = 'assets/images/rain.jpg';
                    } else if (widget.dayWeather[i].weather[0].main == 'Snow') {
                      bgImg = 'assets/images/snow.jpg';
                    }
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              bgImg,
                            ),
                            fit: BoxFit.cover),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all((20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: (90),
                            ),
                            Text(
                              widget.dayWeather[i].weather[0].main,
                              style: const TextStyle(fontSize: (50), fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat("h:mma").format(DateTime.parse(widget.dayWeather[i].dtTxt)),
                                  style:
                                      const TextStyle(fontSize: (18), fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(
                                  width: (10),
                                ),
                                Hero(
                                  tag: 'date-${widget.date}',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      widget.date,
                                      style: const TextStyle(
                                          fontSize: (18), fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Dubai',
                                  style: TextStyle(fontSize: (30), color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${(widget.dayWeather[i].main.temp - 273.15).round()}\u2103',
                                    style: const TextStyle(
                                        fontSize: (50), color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  _buildWeatherParmContainer(
                                      title: 'Humidity', value: widget.dayWeather[i].main.humidity.toString()),
                                  _buildWeatherParmContainer(
                                    title: 'Wind',
                                    value: widget.dayWeather[i].wind.speed.toString() + 'Km/h',
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ));
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: (8)),
      height: (6),
      width: currentPage == index ? (20) : (6),
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular((3)),
      ),
    );
  }

  Container _buildWeatherParmContainer({required String title, required String value}) {
    TextStyle textstyle = const TextStyle(fontSize: 18, color: Colors.black54);
    return Container(
      width: 120,
      padding: const EdgeInsets.only(left: 16),
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textstyle),
          Text(
            value,
            style: textstyle,
          )
        ],
      ),
    );
  }
}
