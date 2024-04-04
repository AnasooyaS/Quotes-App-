import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/constant/global.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_quotes.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<dynamic> _quotes = [];
  final List<Map<String, String>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    try {
      final response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _quotes = data;
        });
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      throw Exception ('Error: $e');
    }
  }

  void _shareQuote(String quote, String author) {
    final message = '$quote - $author';
    Share.share(message);
  }

  void _addToFavorites(String quote, String author) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final quoteData = {'quote': quote, 'author': author};
    _favorites.add(quoteData);
    final favoritesJson = _favorites.map((item) => json.encode(item)).toList();
    prefs.setStringList('favorites', favoritesJson);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Added to Favorites'),
        duration:  Duration(seconds: 2),
      ),
    );
  }
  void _navigateToFavoriteQuotes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteQuotesPage(favoriteQuotes: _favorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Quotes App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: _quotes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _quotes.length,
        itemBuilder: (context, index) {
          final quote = _quotes[index]['text'] as String;
          final author = _quotes[index]['author'] as String;
          return ListTile(
            title: Text(
              quote,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text("- $author"),
            onTap: () {
              _shareQuote(quote, author);
            },
            onLongPress: () {
              _addToFavorites(quote, author);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFavoriteQuotes,
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.favorite,color: Colors.white,),
      ),
    );
  }
}

