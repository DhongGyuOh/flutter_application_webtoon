import 'package:flutter/material.dart';
import 'package:flutter_application_webtoon/models/webtoon_detail_model.dart';
import 'package:flutter_application_webtoon/models/webtoon_episode_model.dart';
import 'package:flutter_application_webtoon/services/api_service.dart';

import '../widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<List<WebtoonEpisodeModel>> webToonEpisode;
  late final Future<WebtoonDetailModel> webToonDetail;
  //final Future<WebtoonDetailModel> webtoonDetail = ApiService.getToonById(widget.id); 이 안되는 이유는
  //constructor에서 extends로 상속받은 wiget(부모)이 참조될 수 없기 때문 그래서 initState에서 widget을 사용해서 받아와야함
  @override
  void initState() {
    webToonDetail = ApiService.getToonById(widget.id);
    webToonEpisode = ApiService.getEpisodeId(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          //title이 아닌 widget.title을 써야하는 이유는 Stateful이기때문에 부모 class에 가서 값을 받아야하기 때문
          style: TextStyle(
              color: Colors.green.shade900,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Hero(
        //Hero: tag에 유니크한 값을 갖는 변수를 넣어주면 Widget을 공유하여 화면 전환 할때 에니메이션 효과를 줄 수 있음
        tag: widget.id,
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    clipBehavior: Clip.hardEdge,
                    height: 300,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Image.network(widget.thumb, headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
                    })),
              ],
            ),
            FutureBuilder(
              future: webToonDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.genre),
                            const SizedBox(
                              width: 90,
                            ),
                            Text(snapshot.data!.age)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(),
                          softWrap: true,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: webToonEpisode,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 500,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      //snapshot.data는 future: 에 입력한 webToonEpisode를 말함
                      itemBuilder: (context, index) {
                        var episode = snapshot.data![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Episode(
                              episode: episode,
                              webtoonId: widget.id,
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
