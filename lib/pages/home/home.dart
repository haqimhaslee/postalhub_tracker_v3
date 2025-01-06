// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/announcement_widget.dart';
import 'package:postalhub_tracker/pages/more/carousel_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 158, 158, 158),
      body: ListView(
        children: const [
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    child: SizedBox(
                      width: 700,
                      child: CarouselAds(),
                    ),
                  ))
            ],
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ClipRRect(
                    child: SizedBox(
                      width: 700,
                      child: AnnouncementWidget(),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}