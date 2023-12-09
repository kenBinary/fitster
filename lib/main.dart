import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitster/screens/createworkout_page.dart';
import 'package:fitster/screens/loginpage.dart';
import 'package:fitster/screens/profile_dashboard.dart';
import 'package:fitster/screens/view_workout_screen.dart';
import 'package:fitster/screens/workout_tracker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexcolor/hexcolor.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('#0C4ACF'),
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
            DrawerHeader(
              decoration: BoxDecoration(
                color: HexColor('#9AB8F9'),
              ),
              child: Image.asset(
                'assets/images/fitster-icon.png',
              ),
            ),
            ListTile(
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: _selectedWidget == 0,
              onTap: () {
                _onItemTapped(0);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Create Plan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: _selectedWidget == 1,
              onTap: () {
                _onItemTapped(1);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'View Plan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: _selectedWidget == 2,
              onTap: () {
                _onItemTapped(2);

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Tracker',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
