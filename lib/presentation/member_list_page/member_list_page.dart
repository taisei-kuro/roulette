import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roulette_app/presentation/add_member_page/add_member_page.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
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
  String displayWord = 'ルーレット';
  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];

  @override
  void initState() {
    super.initState();
    fetchText();
  }

  void fetchText() async {
// ドキュメント一覧取得
    final snapshot =
        await FirebaseFirestore.instance.collection('members').get();
    setState(() {
      documentList = snapshot.docs;

      for (dynamic document in documentList) {
        //documentListに入ってる'text'フィールドを、Stringとして判断してください(as String)
        //Stringにしてからelem配列に一つずつ格納している
        elem.add(document.data()!['text'] as String);
        checkedElem.add(document.data()!['text'] as String);
        //ついでに全てのtextを一旦trueにしてcheckboxに格納する
        checkBox.add(true);
      }
    });
  }

  void startTimer() {
    if (elem.length > 0 && checkedElem.length > 1) {
      isStart = !isStart;
      if (isStart) {
        timer = Timer.periodic(Duration(milliseconds: 100), onTimer);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () async {
              // メンバー追加画面に遷移
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const AddMemberPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
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
          Expanded(
            // StreamBuilderは、非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('members')
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                // データ取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                          subtitle: Text(
                            '通算回数${document['text']}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('members')
                                  .doc(document.id)
                                  .delete();
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                // 読み込み中の時はクルクル出す
                return const Center(
                    child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(strokeWidth: 8.0),
                ));
              },
            ),
          ),
        ],
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
