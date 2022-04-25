import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player_final/music_player/music_player.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome To Our Islamic world',
      home: AudioPlayerUrl(),
      routes: {
        // '/loging': (context) => LoginPage(),
        // '/signup': (context) => SignUpPage(),
        // '/homepage': (context) => HomeScreen(),
        // '/navbar': (context) => Bottomnav(),
        // '/music': (context) => Music(),
        // '/leature': (context) => Leature(),
      },
    ),
  );
}
