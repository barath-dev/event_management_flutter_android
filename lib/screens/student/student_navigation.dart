import 'package:flutter/material.dart';
import 'package:young_minds/screens/common/events_feed_screen.dart';
import 'package:young_minds/screens/common/profile_screen.dart';
import 'package:young_minds/screens/coordinator/my_event.dart';
import 'package:young_minds/screens/student/event_notifications_screen.dart';

class NavStu extends StatefulWidget {
  const NavStu({super.key});

  @override
  State<NavStu> createState() => _NavStuState();
}

class _NavStuState extends State<NavStu> {
  int _pageindex = 0;
  final List<Widget> _children = [
    const EventFeed(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }
  // User user = UserProvider().getUser as User;

  void onPageChanged(int page) {
    setState(() {
      _pageindex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Young Minds',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              color: _pageindex == 0 ? Colors.purple : Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt,
                color: _pageindex == 1 ? Colors.purple : Colors.grey,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
                color: _pageindex == 2 ? Colors.purple : Colors.grey,
              ),
              label: ""),
        ],
        currentIndex: _pageindex,
        onTap: navigationTapped,
      ),
    );
  }
}
