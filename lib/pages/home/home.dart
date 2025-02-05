// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/announcement_widget.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/carousel_ads.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/profile_widget.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/quickaction_widget.dart';

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
        appBar: AppBar(
          title: const Text('Postal Hub'),
        ),
        body: ListView(
          children: const <Widget>[
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 600,
                        child: ProfileOverviewWidget(),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 600,
                        child: CarouselAds(),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 600,
                        child: QuickactionWidget(),
                      ),
                    )),
              ],
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ClipRRect(
                      child: SizedBox(
                        width: 700,
                        child: AnnouncementWidget(),
                      ),
                    ))
              ],
            ),
          ],
        ));
  }
}
