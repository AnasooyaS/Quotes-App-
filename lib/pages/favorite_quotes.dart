import 'package:flutter/material.dart';

class FavoriteQuotesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteQuotes;

  const FavoriteQuotesPage({Key? key, required this.favoriteQuotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          final quote = favoriteQuotes[index]['quote'];
          final author = favoriteQuotes[index]['author'];
          return ListTile(
            title: Text(quote!),
            subtitle: Text("- $author"),
          );
        },
      ),
    );
  }
}
