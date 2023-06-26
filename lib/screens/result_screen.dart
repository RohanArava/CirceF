import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../chart.dart';

class Result extends StatefulWidget {
  Result({super.key, required this.id, required this.name, required this.sess});
  static String route = "ptscr";
  final String id;
  final String name;
  final int sess;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, dynamic> details = {
    "bp": {"sys": 0, "dia": 0},
    "ecg": [],
    "temp": 0,
    "spo2": 0,
    "bpm": 0
  };

  Future<void> getDetails() async {
    print("here");
    var response = await http
        .get(Uri.parse("http://10.0.55.227:5005/details/${widget.id}/${widget.sess}"));
    setState(() {
      details = json.decode(response.body);
    });
    print(details);
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          Text("Temperature",
                              style:
                                  TextStyle(fontSize: 28, color: Colors.green)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/thermometer.png",
                                width: size.width / 6,
                              ),
                              Text("${details["temp"]} °C",
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Image.asset(
                                "assets/oximeter.png",
                                width: size.width / 2.1,
                              ),
                              Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 18),
                                      children: [
                                        const TextSpan(
                                            text: "SpO2 ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green)),
                                        TextSpan(
                                            text: "${details['spo2']}", 
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: "%",
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 18),
                                      children: [
                                        const TextSpan(
                                            text: "Heart rate",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green)),
                                        TextSpan(
                                            text: "${details['bpm']}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: "bpm",
                                            style:
                                                TextStyle(color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: size.width / 3,
                  backgroundColor: Colors.black,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width / 6,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 18),
                          children: [
                            const TextSpan(
                              text: "Sys    ",
                            ),
                            TextSpan(
                                text: "${(details["bp"] as Map)["sys"]}",
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold)),
                            TextSpan(text: "    mm/Hg")
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 18),
                          children: [
                            const TextSpan(
                              text: "Dia    ",
                            ),
                            TextSpan(
                                text: "${(details["bp"] as Map)["dia"]}",
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold)),
                            TextSpan(text: "    mm/Hg")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Blood Pressure",
                        style: TextStyle(fontSize: 28, color: Colors.green),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                        width: size.width,
                        child: THChart(
                          data: details["ecg"].cast<int>(),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text("ECG", style: TextStyle(fontSize: 28)),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
