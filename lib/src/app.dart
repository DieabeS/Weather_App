import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:weather_app/ui/screens/weather_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      builder: (context, widget) =>
          ResponsiveWrapper.builder(ClampingScrollWrapper.builder(context, widget!), breakpoints: [
        const ResponsiveBreakpoint.resize(350, name: MOBILE),
        const ResponsiveBreakpoint.autoScale(600, name: TABLET),
      ]),
      home: const WeatherScreen(),
    );
  }
}
