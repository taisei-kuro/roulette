import 'package:flutter/material.dart';
import 'package:roulette_app/roulette_page/roulette_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 70,
          child: ElevatedButton(
            onPressed: () {
              // メンバー追加画面に遷移
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoulettePage(),
                    //以下を追加
                    fullscreenDialog: true,
                  ));
            },
            child: const Text(
              'スタート',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
