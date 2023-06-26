import 'package:flutter/material.dart';
import 'package:smoke/screens/result_screen.dart';


class SelectSess extends StatelessWidget {
  const SelectSess(
      {super.key, required this.id, required this.name, required this.num});
  static String route = "ssscr";
  final String id;
  final String name;
  final int num;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Session",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
          height: size.height / 1.1,
          child: num == 0
              ? const Center(
                  child: Text(
                    "No Sessions",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: num,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return Result(
                                id: id,
                                name: name,
                                sess: index + 1,
                              );
                            }));
                          },
                          title: Text(
                            "Session ${index + 1}",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        Divider()
                      ],
                    );
                  })),
    );
  }
}
