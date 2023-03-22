import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        Container(
            width: 400,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Image.network(thumb, headers: const {
              "User-Agent":
                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
            })),
        const SizedBox(
          height: 20,
        ),
        Text(id)
      ]),
    );
  }
}
