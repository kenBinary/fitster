import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/screens/createworkout_page.dart';
import 'package:fitster/screens/loginpage.dart';
import 'package:fitster/screens/profile_dashboard.dart';
import 'package:fitster/screens/view_workout_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitster',
      initialRoute:
          (FirebaseAuth.instance.currentUser == null ? '/login' : '/main'),
      routes: {
        '/login': (context) {
          return LoginPage();
        },
        '/main': (context) {
          return const MyHomePage();
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedWidget = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ProfileDashboard(),
    CreateWorkoutPage(),
    ViewWorkout(),
    WorkoutTracker(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedWidget = index;
    });
  }

  String displayName = '';

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      displayName = RegExp(r'^([^@]+)').firstMatch(user.email!)!.group(0)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hello, $displayName'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            tooltip: 'Log Out Button',
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _widgetOptions[_selectedWidget],
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
              selected: _selectedWidget == 0,
              onTap: () {
                _onItemTapped(0);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Create Plan'),
              selected: _selectedWidget == 1,
              onTap: () {
                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Plan'),
              selected: _selectedWidget == 2,
              onTap: () {
                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Tracker'),
              selected: _selectedWidget == 3,
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
