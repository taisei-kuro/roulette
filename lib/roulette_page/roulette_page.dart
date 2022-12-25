import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roulette/roulette.dart';

// class RoulettePage extends StatefulWidget {
//   const RoulettePage({super.key});

//   @override
//   State<RoulettePage> createState() => _RoulettePageState();
// }

// class _RoulettePageState extends State<RoulettePage>
//     with SingleTickerProviderStateMixin {
//   late RouletteController _controller;
//   bool _clockwise = true;

//   @override
//   void initState() {
//     _controller = RouletteController(
//         group: RouletteGroup([
//           const RouletteUnit.noText(color: Colors.red),
//           const RouletteUnit.noText(color: Colors.green),
//           const RouletteUnit.noText(color: Colors.blue),
//           const RouletteUnit.noText(color: Colors.yellow),
//         ]),
//         vsync: this);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ルーレット'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(64.0),
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   SizedBox(
//                     width: 260,
//                     height: 260,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 30),
//                       child: Roulette(
//                         controller: _controller,
//                         style: const RouletteStyle(
//                           dividerThickness: 4,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Icon(
//                     FontAwesomeIcons.accessibleIcon,
//                     size: 45,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 200,
//               height: 70,
//               child: ElevatedButton(
//                 onPressed: () => _controller.rollTo(
//                   2,
//                   clockwise: _clockwise,
//                   offset: Random().nextDouble(),
//                 ),
//                 child: const Text(
//                   'スタート',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  _RoulettePageState createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> {
  // 画面に表示する要素のインデックス番号を格納する用
  int index = 0;
  // ルーレットの起動有無フラグ
  bool isStart = false;
  // Timerオブジェクトを格納する用
  var timer;
  // ルーレットに選択肢として追加した要素を格納する用
  List<String> elem = [];
  // 要素にチェックが入っているかをboolで格納しておく用
  List<bool> checkBox = [];
  // チェックボックスで選択されている要素を格納する用
  List<String> checkedElem = [];
  // 画面上部に表示する要素を格納する用
  String displayWord = 'Roulette';
  // テキストフィールドにアクセスするためのコントローラー
  TextEditingController addController = TextEditingController();

  void startTimer() {
    if (elem.isNotEmpty && checkedElem.length > 1) {
      isStart = !isStart;
      if (isStart) {
        timer = Timer.periodic(const Duration(milliseconds: 100), onTimer);
      } else {
        setState(() {
          timer.cancel();
        });
      }
    }
  }

  void onTimer(Timer timer) {
    setState(() {
      index++;
      if (index > checkedElem.length - 1) {
        index = 0;
      }
      displayWord = checkedElem[index];
    });
  }

  void addElem() {
    if (addController.text != '' && !isStart) {
      setState(() {
        elem.add(addController.text);
        checkBox.add(true);
        checkedElem.add(addController.text);
        addController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                color: Colors.green,
                child: Center(
                  child: Text(
                    displayWord,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.playlist_add_outlined,
                    color: Colors.green,
                    size: 40.0,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: addController,
                    decoration: const InputDecoration(
                      hintText: 'add member',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      addElem();
                    },
                    child: const Text('追加'),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                color: Colors.blue[100],
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: checkBox.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              value: checkBox[index],
                              title: Text(
                                elem[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (val) {
                                if (!isStart) {
                                  setState(() {
                                    checkBox[index] = val!;
                                    if (val) {
                                      checkedElem.add(elem[index]);
                                    } else {
                                      checkedElem.remove(elem[index]);
                                    }
                                    // チェックした選択肢を追加、削除した際にはRangeErrorを回避するために一旦結果表示をリセット
                                    displayWord = 'Roulette';
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isStart == true
            ? const Icon(
                Icons.whatshot,
                color: Colors.pink,
              )
            : const Icon(
                Icons.whatshot,
              ),
        onPressed: () {
          startTimer();
        },
      ),
    );
  }
}
