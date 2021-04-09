import 'package:flutter/material.dart';
import 'home_trips.dart';
import 'profile_trips.dart';
import 'search_trips.dart';

class PlatziTrips extends StatefulWidget {
 

  @override
  _PlatziTripsState createState() => _PlatziTripsState();
}

class _PlatziTripsState extends State<PlatziTrips> {

  int indexTap = 0;

  final List<Widget> widgetsChildren = [
    HomeTrips(),
    SearchTrips(),
    ProfileTrips()
  ];

  @override
  Widget build(BuildContext context) {

    void onTapTapped(int index){
      setState(() {
        indexTap = index;
      });

    } 

    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.purple
        ),
        child: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: indexTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ""
              
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: ""
              
              ),  
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ""
              
              )
          ])),
    );
  }
}