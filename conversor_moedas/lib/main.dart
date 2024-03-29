import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=9d27b03c";

void main() async {
  //print(await getData());

  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
                break;
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.green,
                  );
                }
            }
          }),
    );
  }
}

Future<Map> getData() async {
  //fazer uma requisição assincrona para aplicação nao parar enquanto recebe
  http.Response response = await http.get(request);
  //print(json.decode(response.body)["results"]["currencies"]["USD"]);
  return json.decode(response.body);
}
