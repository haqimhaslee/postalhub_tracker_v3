import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'About this new parcel tracking system',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '• This parcel tracking system is designed to provide real-time updates and tracking information for your shipments.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Our System Developers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Card(
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      width: 400,
                      'assets/images/dev_pic1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Technology used to develop this system',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '• The system utilizes Google Cloud services and the Gemini API for efficient data management and integration.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'We are excited to bring the latest/exciting technology to you',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '• Our team is dedicated to bringing you cutting-edge technology to enhance your shipping and tracking experience.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'This is just the beginning of a multiyear project',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  '• We are committed to expanding and improving this system over the coming years to provide even more features and reliability.',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 50.0),
                const Text(
                  'More exciting features coming soon... ✌️',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                const SizedBox(height: 50.0),
                FilledButton(
                    onPressed: () => showLicensePage(
                          context: context,
                        ),
                    child: const Text("Licenses")),
                const SizedBox(height: 10.0),
                FilledButton(
                    onPressed: () => _launchUrl(
                        'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
                    child: const Text("Easter Egg 🥚")),
              ],
            ),
          ],
        ));
  }
}
