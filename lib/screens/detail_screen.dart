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
      body: Hero(
        //Hero: tag에 유니크한 값을 갖는 변수를 넣어주면 Widget을 공유하여 화면 전환 할때 에니메이션 효과를 줄 수 있음
        tag: id,
        child: Column(children: [
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
      ),
    );
  }
}
