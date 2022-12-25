import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette_app/presentation/add_member_page/add_member_page.dart';
import 'package:roulette_app/presentation/login_page/login_page.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // ログアウト
              await FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // StreamBuilderは、非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('members')
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  // 取得した投稿メッセージ一覧を元にリスト表示
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                            title: Text(document['text']),
                            subtitle: Text('通算回数${document['text']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                // 投稿メッセージのドキュメントを削除
                                await FirebaseFirestore.instance
                                    .collection('members')
                                    .doc(document.id)
                                    .delete();
                              },
                            )),
                      );
                    }).toList(),
                  );
                }
                // データが読込中の場合
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
        child: const Icon(Icons.add),
        onPressed: () async {
          // メンバー追加画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const AddMemberPage();
            }),
          );
        },
      ),
    );
  }
}
