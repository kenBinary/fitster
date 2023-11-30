import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/screens/createworkout_page.dart';
import 'package:fitster/screens/loginpage.dart';
import 'package:fitster/screens/profile_dashboard.dart';
import 'package:fitster/screens/workout_tracker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      // home: MyHomePage(title: appTitle),
      initialRoute:
          (FirebaseAuth.instance.currentUser == null ? '/login' : 'main'),
      routes: {
        '/login': (context) {
          return const LoginPage();
        },
        '/main': (context) {
          return const MyHomePage(title: 'test');
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileDashboard(),
    CreateWorkoutPage(),
    Text('test'),
    WorkoutTracker(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _widgetOptions[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Profile'),
            ),
            ListTile(
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Create Plan'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Plan'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Tracker'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
