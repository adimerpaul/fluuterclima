import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String key='1adb35ebca4e732e1180b6550b57b790';
  String city='Santa cruz, BO';

  Future fetchData() async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key&units=metric&lang=es'));
    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      return result;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final weatherData = snapshot.data;

                    return Column(
                      children: [
                        Text(
                          'Clima en $city:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '${weatherData['weather'][0]['description']}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Temperatura: ${weatherData['main']['temp']}°C',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  }
                }
            )
          ]
        ),
      ),
    );
  }
}
