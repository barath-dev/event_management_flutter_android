// import 'package:flutter/material.dart';
// import 'package:youngmind/screens/common/events_feed_screen.dart';
// import 'package:youngmind/screens/common/profile_screen.dart';

// class NavigationScreen extends StatefulWidget {
//   const NavigationScreen({super.key});

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Spacer(),
//         const Text(
//           'Young Minds',
//           style: TextStyle(
//               color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const EventFeed()));
//                 },
//                 icon: const Icon(
//                   Icons.home,
//                   color: Colors.black,
//                 )),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.event,a
//                   color: Colors.black,
//                 )),
//             IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>  ProfileScreen(isStudent: ,)));
//                 },
//                 icon: const Icon(
//                   Icons.person,
//                   color: Colors.black,
//                 )),
//           ],
//         ),
//       ],
//     );
//   }
// }
