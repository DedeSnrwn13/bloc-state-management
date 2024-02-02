import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latihan_state_management_bloc/bloc/managenews_bloc.dart';
import 'package:latihan_state_management_bloc/layout/detailview.dart';

class ListNews extends StatelessWidget {
  final List news;
  String searchText;

  ListNews({super.key, required this.news, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    TextEditingController _search = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("List News")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          TextField(
            controller: _search,
            decoration: const InputDecoration(labelText: 'Cari Berita'),
          ), // TextField
          ElevatedButton(
            onPressed: () {
              final search = _search.text;
              // Dispatch login event to Bloc
              context.read<ManagenewsBloc>().add(LoadListNewsEvent(keyword: search));
            },
            child: const Text("Cari"),
          ), // ElevatedButton
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: news.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> newsItem = news[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      newsItem['img'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(newsItem['title']),
                    subtitle: Text(newsItem['date']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailNews(
                            newsId: newsItem['id'],
                          ),
                        ),
                      ).then((value) {
                        final search = _search.text;

                        context.read<ManagenewsBloc>().add(LoadListNewsEvent(keyword: search));
                      });
                    },
                  ),
                );
              },
            ),
          ) // Expanded
        ]),
      ), // Padding
    );
  }
}
