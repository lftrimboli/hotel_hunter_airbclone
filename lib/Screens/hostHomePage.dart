import 'package:flutter/material.dart';
import 'package:hotel_hunter/Models/appConstants.dart';
import 'package:hotel_hunter/Views/textWidgets.dart';

import 'accountPage.dart';
import 'bookingsPage.dart';
import 'inboxPage.dart';
import 'myPostingsPage.dart';

class HostHomePage extends StatefulWidget {

  static final String routeName = '/hostHomePageRoute';
  final int index;

  HostHomePage({Key key, this.index}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {

  int _selectedIndex = 3;

  final List<String> _pageTitles = [
    'Bookings',
    'My Postings',
    'Inbox',
    'Profile'
  ];

  final List<Widget> _pages = [
    BookingsPage(),
    MyPostingsPage(),
    InboxPage(),
    AccountPage(),
  ];

  BottomNavigationBarItem _buildNavigationItem(int index, IconData iconData, String text) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: AppConstants.nonSelectedIconColor,),
      activeIcon: Icon(iconData, color: AppConstants.selectedIconColor,),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? AppConstants.selectedIconColor : AppConstants.nonSelectedIconColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    this._selectedIndex = widget.index ?? 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: _pageTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          _buildNavigationItem(0, Icons.calendar_today, _pageTitles[0]),
          _buildNavigationItem(1, Icons.home, _pageTitles[1]),
          _buildNavigationItem(2, Icons.message, _pageTitles[2]),
          _buildNavigationItem(3, Icons.person_outline, _pageTitles[3]),
        ],
      ),
    );
  }
}
