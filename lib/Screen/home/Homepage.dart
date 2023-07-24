import 'package:flutter/material.dart';
import 'package:service/Widget/mybutton.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyButton(
          name: ' login',
          width: 40,
          colors: Colors.black87,
          onPressed: () {},
          borderRadius: 20,
          height: 40,
          colorwrite: Colors.white,
        ),
      ),
    );
  }
}
