import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../chart.dart';

class Result2 extends StatelessWidget {
  Result2({super.key, required this.id, required this.name, required this.sess, required this.details});
  static String route = "ptscr";
  final String id;
  final String name;
  final int sess;
  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
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
                                width: size.width / 2.4 ,
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
                                            text: " %",
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
                          style: TextStyle(fontSize: 14 ),
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
