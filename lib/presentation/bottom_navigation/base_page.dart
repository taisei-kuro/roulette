import 'package:flutter/material.dart';
import 'package:roulette_app/presentation/calendar_page/calendar_page.dart';
import 'package:roulette_app/presentation/member_list_page/member_list_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  static const _screens = [
    MemberListPage(),
    CalendarPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'メンバー'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'カレンダー'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
