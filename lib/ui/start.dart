import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/common/bottom_item.dart';
import 'package:siteica_user/services/database_service.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _databaseService = Injector.appInstance.get<DatabaseService>();
  bool _loading = true;
  int _currentIndex = 0;

  initDatabase() async {
    await _databaseService.initialise();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child: CircularProgressIndicator()) : Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in BottomItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in BottomItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.title,
            )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
