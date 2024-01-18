import 'package:flutter/material.dart';
import 'package:youngmind/screens/common/profile_screen.dart';
import 'package:youngmind/screens/coordinator/create_event.dart';
import 'package:youngmind/screens/coordinator/my_event.dart';

class NavCoord extends StatefulWidget {
  const NavCoord({super.key});

  @override
  State<NavCoord> createState() => _NavCoordState();
}

class _NavCoordState extends State<NavCoord> {
  int _pageindex = 0;
  final List<Widget> _children = [
    const CreateEvent(),
    const Eventist(),
     ProfileScreen(
      isStudent: false,
    ),
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
        title: const Text('Young Minds'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
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
