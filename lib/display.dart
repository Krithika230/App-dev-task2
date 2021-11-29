import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {

    String name,email;
    DisplayPage({required this.name, required this.email});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Name : ${name}'),
                        Text('Email : ${email}'),
                    ],
                ), //Column
        ) //Center
      );//Scaffold
    }
}