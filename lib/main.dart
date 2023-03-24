import 'package:flutter/material.dart';
import 'package:flutter_application_webtoon/models/webtoon_model.dart';
import 'package:flutter_application_webtoon/services/api_service.dart';
import 'package:flutter_application_webtoon/widgets/webtoon_widget.dart';

void main() {
  ApiService.getTodayToons();
  //ApiService.getTodayToons: List<WebtoonModel> 를 return하는 메소드
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;
  void waitForwebToons() async {
    webtoons = await ApiService.getTodayToons();
    //.getTodayToons에서 webtoons로 List<WebtoonModel> 값을 return 해주고
    isLoading = false;
    setState(() {});
    //setState: 현재 상태를 적용한 화면을 다시 그려주는 역할
  }

  @override
  void initState() {
    //initState: 앱이 시작할때 동작(생명주기)
    super.initState();
    waitForwebToons();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    //dispose: 위젯이 제거되기 전에 한번만 호출되는 함수 (initState와 쌍을 이룸)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'WebToons',
          style: TextStyle(
              color: Colors.indigo.shade900, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodayToons();
  //ApiService.getTodayToons로 return 받은 List<WebtoonModel> 을 webtoons에 넣음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'WebToonAPI',
        style: TextStyle(
            color: Colors.purpleAccent.shade700,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      )),
      body: FutureBuilder(
        //FutureBuilder: 비동기적으로 데이터(Future)를 가져올 때 사용하는 위젯(주로 Network요청,DB조회할 때 사용)
        future: webtoons,
        //furure: 처리할 future 객체를 전달
        builder: (context, futureResult) {
          //builder 콜백함수: Build할 context와 snapshot 이름을 정하고 future상태를 정해진 snapshot을 통해 체크함(hasData 등)
          if (futureResult.hasData) {
            //hasData: snapshot에 데이터가 있다면
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: makeList(futureResult)),
                //makeList
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> futureResult) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      //scrollDirection: 스크롤 방향을 정함
      itemCount: futureResult.data!.length,
      //itemCount: 총 data의 수를 넣어 주면됨
      itemBuilder: (context, index) {
        //itemBuilder: 리스트 아이템을 생성할 위젯을 반환하는 함수로, 입력된 context와 index를 통해 아이템을 생성함
        var webtoon = futureResult.data![index];
        //위에 if문에 futureResult.hasData를 타고 들어왔기 때문에 data!로 값에 Null이 존재하지않다는 명시를 해줌
        return WebtoonListPage(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(
        //separatorBuilder: ListView의 item과 함께 구분자로 사용할 위젯을 추가할 수 있음
        width: 20,
      ),
    );
  }
}
