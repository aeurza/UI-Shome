import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  final List<String> _pageTitles = [
    "Home",
    "Control",
    "Data",
    "Exit"
  ];

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      

      appBar: AppBar(
        // backgroundColor: ,
        title: Center(
          child: Text(
            _pageTitles[_selectedIndex],
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(107, 11, 102, 230), fontSize: 30),
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub),
            label: 'Control',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics),
            label: 'Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ), //
        ],
      ),

      body: Center(
        child: Text(
          'Page: ${_pageTitles[_selectedIndex]}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
