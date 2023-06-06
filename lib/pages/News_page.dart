import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> _articles = [];

  @override
  void initState() {
    super.initState();
    fetchNewsArticles();
  }

  Future<void> fetchNewsArticles() async {
    final apiKey =
        'ed3865863a60498684fe61f7052d74be'; // Replace with your actual API key
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        _articles = jsonData['articles'];
      });
    } else {
      // Handle error case
      print('Failed to fetch news articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Broadcast'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: _articles.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final article = _articles[index];

          return ListTile(
            leading: article['urlToImage'] != null
                ? Image.network(
                    article['urlToImage'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: 80,
                    height: 80,
                    child: Icon(Icons.image),
                  ),
            title: Text(article['title']),
            subtitle: Text(article['description']),
            onTap: () {
              // Handle article tap event
              // You can navigate to a detailed news page or open the news URL in a web view
              // Example:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => NewsDetailPage(article: article),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
