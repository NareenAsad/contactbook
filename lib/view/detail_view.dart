import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/controller/provider/profidermanager.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> number;

  DetailPage({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<NumberProvider>(context, listen: false);

    void _toggleFav(Map<String, String> contact) {
      final isFav = _provider.isFavorite(contact);

      if (isFav) {
        _provider.removeFromFavorites(contact);
      } else {
        _provider.addToFavorites(contact);
      }
    }

    Color heartColor = _provider.isFavorite(number) ? Colors.red : Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  '${number['name']}',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  'Mobile: ${number['number']}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Icon(Icons.phone, color: Colors.white),
              SizedBox(width: 5),
              Icon(Icons.messenger, color: Colors.white),
              SizedBox(width: 5),
              Icon(Icons.camera_outdoor_rounded, color: Colors.white),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 40),
          Card(
            elevation: 4,
            color: Colors.blueGrey,
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align children to the start
                children: [
                  Text(
                    'Organization: ${number['organization']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 4,
            color: Colors.blueGrey,
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: heartColor, // Use the defined color here
              ),
              onPressed: () {
                _toggleFav(number);
              },
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
