// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:postalhub_tracker/pages/more/about/about.dart';
import 'package:postalhub_tracker/pages/more/updates_info/updates_info_at.dart';
import 'package:postalhub_tracker/pages/home/home_widgets/carousel_viewer.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

Future<void> _privacypolicy(BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse(
          'https://www.termsfeed.com/live/9187d68f-f1e8-4d89-921f-f8432437ba97'),
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(
          toolbarColor: theme.colorScheme.surface,
          navigationBarColor: theme.colorScheme.surface,
        ),
        shareState: CustomTabsShareState.off,
        urlBarHidingEnabled: true,
        showTitle: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        preferredBarTintColor: theme.colorScheme.surface,
        preferredControlTintColor: theme.colorScheme.onSurface,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> _customerServices(BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse('https://forms.gle/bZcSg3W2QrxSJrkL6'),
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(
          toolbarColor: theme.colorScheme.surface,
          navigationBarColor: theme.colorScheme.surface,
        ),
        shareState: CustomTabsShareState.off,
        urlBarHidingEnabled: true,
        showTitle: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        preferredBarTintColor: theme.colorScheme.surface,
        preferredControlTintColor: theme.colorScheme.onSurface,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & More'),
      ),
      body: ListView(
        children: [
          const Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 8),
                  child: ClipRRect(
                    child: SizedBox(
                      width: 600,
                      child: CarouselViewer(),
                    ),
                  ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 0, top: 15),
            child: Text(
              "My Account",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: const Text('Personal Information'),
            subtitle: const Text('View and edit personal information'),
            leading: const Icon(Icons.person_outline_rounded),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Change Password'),
            subtitle: const Text('Change account password'),
            leading: const Icon(Icons.password_rounded),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 0, top: 20),
            child: Text(
              "App Settings",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Change app theme'),
            leading: const Icon(Icons.color_lens_rounded),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Language'),
            leading: const Icon(Icons.language_rounded),
            subtitle: const Text('Change app language'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Notification'),
            subtitle: const Text('Manage notification settings'),
            leading: const Icon(Icons.notifications_rounded),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 0, top: 20),
            child: Text(
              "Information",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: const Text('Feedback Center'),
            subtitle: const Text('Send feedback to us'),
            leading: const Icon(Icons.info_rounded),
            onTap: () {
              _customerServices(context);
            },
          ),
          ListTile(
            title: const Text('Terms and Privacy Policy'),
            subtitle: const Text('View Terms and Privacy Policy'),
            leading: const Icon(Icons.developer_board_rounded),
            onTap: () => _privacypolicy(context),
          ),
          ListTile(
            title: const Text('Licences'),
            subtitle: const Text('View open source licences'),
            leading: const Icon(Icons.description_outlined),
            onTap: () => showLicensePage(
              context: context,
            ),
          ),
          ListTile(
            title: const Text('Release Updates'),
            subtitle: const Text('View release updates'),
            leading: const Icon(Icons.update_rounded),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatesInfoAt()));
            },
          ),
          ListTile(
            title: const Text('App info'),
            subtitle: const Text('View app information'),
            leading: const Icon(Icons.info_outline_rounded),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const About()));
            },
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28, 20, 28, 0),
              child: Text(
                "Copyright Campus Postal Hub © 2024 - 2025",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28, 0, 28, 25),
              child: Text(
                "All rights reserved",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
