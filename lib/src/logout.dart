import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('로그아웃'),
              ElevatedButton(onPressed: () {}, child: Text('로그아웃'))
            ],
          ),
        ),
      ),
    );
  }
}
