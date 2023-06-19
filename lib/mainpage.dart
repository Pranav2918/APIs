import 'package:flutter/material.dart';
import 'package:searchwithapi/Music%20API/musics.dart';

import 'Users API/users.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APIs"),
      ),
      body: Center(
        child: Row(
          children: [
            TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UsersPage())),
                child: const Text("Fetch Users")),
            TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MusicPage())),
                child: const Text("Fetch Musics"))
          ],
        ),
      ),
    );
  }
}
