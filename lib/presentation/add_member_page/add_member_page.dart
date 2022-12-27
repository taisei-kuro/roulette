// 投稿画面用Widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});
  @override
  _AddMemberPageState createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  // 入力したメンバーの名前を格納する変数
  String memberText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー追加'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // メンバーの名前入力
              TextFormField(
                decoration: const InputDecoration(labelText: '追加メンバー'),
                onChanged: (String value) {
                  setState(() {
                    memberText = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('追加'),
                  onPressed: () async {
                    final date =
                        DateTime.now().toLocal().toIso8601String(); // 現在の日時を取得
                    // メンバーを追加する処理
                    await FirebaseFirestore.instance
                        .collection('members')
                        .doc() // ドキュメントID自動生成
                        .set({'text': memberText, 'date': date});
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
