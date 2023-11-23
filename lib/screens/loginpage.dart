import 'package:flutter/material.dart';

class loginpage extends StatelessWidget {
  const loginpage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(
    child: Padding(
      padding: const EdgeInsets.all(0.0),

      child: Column(
        children: [
          Image.asset(
            '../lib/images/Fitser_Logo.png',
            width: 300.0,
            height: 250.0,
          ),

          const Padding(
            padding: EdgeInsets.all(1.0),
            child: Text(
              'Fitser',
              style: TextStyle(
                fontSize: 40.0, 
                fontWeight: FontWeight.bold
                ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(1.0),
            child: Text(
              'Workout Planner and Tracker',
              style: TextStyle(fontSize: 15.0, 
              fontStyle: FontStyle.italic
              ),
            ),
          ),

         Center(
           child: Column(
            
           children: [
             Padding(
               
               padding: const EdgeInsets.all(8.0),
               child: MaterialButton(
                 onPressed: () {},
                 color: Colors.white,
                 height: 50,
                 minWidth: 300,
                 child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('../lib/images/G_Logo.png', height: 30, width: 30),
              SizedBox(width: 15),
              const Text('Sign in with Google'),
            ],
                 ),
               ),
             ),
         
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: MaterialButton(
                 onPressed: () {},
                 color: Colors.black,
                 height: 50,
                 minWidth: 300,
                 child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('../lib/images/X_Logo.png', height: 30, width: 30),
              SizedBox(width: 15),
              const Text('Sign in with Twitter', style: TextStyle(color: Colors.white)),
            ],
                 ),
               ),
             ),
         
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: MaterialButton(
                 onPressed: () {},
                 color: Colors.redAccent,
                 height: 50,
                 minWidth: 300,
                 child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('../lib/images/E_Logo.png', height: 30, width: 30),
              SizedBox(width: 15),
              const Text('Sign in with Email', style: TextStyle(color: Colors.white)),
            ],
                 ),
               ),
             ),
         
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: MaterialButton(
                 onPressed: () {},
                 color: Colors.blueAccent,
                 height: 50,
                 minWidth: 300,
                 child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('../lib/images/F_Logo.png', height: 30, width: 30),
              SizedBox(width: 15),
              const Text('Sign in with Facebook', style: TextStyle(color: Colors.white)),
            ],
                 ),
               ),
             ),
           ],
         ),
         ),

        ],
      ),
    ),
  ),
  );
  }
}