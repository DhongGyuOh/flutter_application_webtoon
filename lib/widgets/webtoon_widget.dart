import 'package:flutter/material.dart';
import 'package:flutter_application_webtoon/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //GestureDetector: 특정 Gesture가 있을 때 이벤트가 발동하도록 도와주느 Widget
      onTap: () {
        //onTap: Tap이 되었을 경우
        Navigator.push(
          //Navigator: route를 push할 수있는 Widget, route는 Widget을 애니메이션효과로 감싸서 마치 스크린처럼 보여줌
          context,
          MaterialPageRoute(
              //MaterialPageRoute: StatelessWidget을 Route로 감싸주는 역할을 함
              builder: (context) =>
                  //builder: route를 만들어줌
                  DetailScreen(title: title, thumb: thumb, id: id),
              fullscreenDialog: true),
        );
      },

      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            //clipBehavior: 자식의 부모영역 침범을 제어할수있게해줌
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3))
                ]),
            child: Image.network(
              //.network(URL을 사용하여 이미지를 가져옴)
              thumb,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                // 따로 User-Agent 값을 추가하지 않으면 기본값으로 `Dart/<version> (dart:io)` 가 들어가서 네이버에서 차단함
                // 해결: headers에 useragent 추가 (https://api.flutter.dev/flutter/dart-io/HttpClient/userAgent.html)
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }
}
