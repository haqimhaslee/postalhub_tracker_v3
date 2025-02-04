import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class UpdatesInfoAt extends StatefulWidget {
  const UpdatesInfoAt({super.key});

  @override
  State<UpdatesInfoAt> createState() => _UpdatesInfoAtState();
}

class _UpdatesInfoAtState extends State<UpdatesInfoAt> {
  final int _limit = 5;
  final List<DocumentSnapshot> _updates = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot? _lastDocument;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchUpdates();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchUpdates();
      }
    });
  }

  Future<void> _fetchUpdates() async {
    if (_isLoading || !_hasMore) return;
    setState(() => _isLoading = true);

    Query query = FirebaseFirestore.instance
        .collection('version_update_info')
        .orderBy('ver_date', descending: true)
        .limit(_limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();
    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
      setState(() {
        _updates.addAll(querySnapshot.docs);
        _hasMore = querySnapshot.docs.length == _limit;
      });
    } else {
      setState(() => _hasMore = false);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Release Updates')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _updates.length + 1,
        itemBuilder: (context, index) {
          if (index == _updates.length) {
            return _isLoading
                ? Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    period: const Duration(milliseconds: 600),
                    baseColor:
                        Theme.of(context).colorScheme.surfaceContainerLowest,
                    highlightColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Card(
                        elevation: 0,
                        child: SizedBox(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                          ),
                        )),
                  )
                : const SizedBox();
          }
          Map<String, dynamic> data =
              _updates[index].data() as Map<String, dynamic>;
          Timestamp timestamp = data['ver_date'];
          DateTime dateTime = timestamp.toDate();
          String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formattedDate, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    MarkdownBody(
                      onTapLink: (text, href, title) {
                        if (href != null) {
                          launchUrl(Uri.parse(href));
                        }
                      },
                      data: data['ver_info']?.replaceAll(r'\n', '\n') ??
                          'No Content',
                      styleSheet:
                          MarkdownStyleSheet.fromTheme(Theme.of(context)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
