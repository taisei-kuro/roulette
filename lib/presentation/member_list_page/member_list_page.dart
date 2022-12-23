import 'package:flutter/material.dart';

class MemberListPage extends StatelessWidget {
  const MemberListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー'),
      ),
      body: const Center(child: Text('メンバー', style: TextStyle(fontSize: 32.0))),
    );
  }
}
