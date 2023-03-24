import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({super.key, required this.episode, required this.webtoonId});

  final WebtoonEpisodeModel episode;
  final dynamic webtoonId;
  onButtonTap() async {
    final url = Uri.parse(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.access_alarm,
              size: 15,
              color: Colors.indigoAccent.shade700,
            ),
            Text('${episode.date}/'),
            Icon(
              Icons.rate_review_outlined,
              size: 15,
              color: Colors.indigoAccent.shade700,
            ),
            Text('${episode.rating}/'),
            Icon(
              Icons.open_in_new_rounded,
              size: 15,
              color: Colors.indigoAccent.shade700,
            ),
            Text('${episode.title} '),
          ],
        ),
      ),
    );
  }
}
