import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Because Chuck Norris says so!')),
        body: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String data = '';

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body)['value'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle the error (e.g., show an error message)
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: fetchData,
          child: const Text('Fetch Data'),
        ),
        const SizedBox(height: 20),
        Text(data),
      ],
    );
  }
}
