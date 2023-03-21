class WebtoonModel {
  final String title, thumb, id;
  WebtoonModel.fromJson(Map<String, dynamic> json)
      //named constructor(생성자) 생성자에 이름(fromJson)을 정해주는 형식 Dart에만 있는 형식임
      : id = json['id'],
        title = json['title'],
        thumb = json['thumb'];
//{id: 802872,
//title: DARK MOON: 회색 도시,
//thumb: https://image-comic.pstatic.net/webtoon/802872/thumbnail/thumbnail_IMAG21_c80f6d62-0971-4806-9aa5-9cc0d9e5599e.jpg}
}
