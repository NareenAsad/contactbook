import 'package:contact_book/controller/provider/profidermanager.dart';
import 'package:contact_book/view/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> number;

  DetailPage({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<NumberProvider>(context, listen: false);

    void _toggleFav(Map<String, dynamic> contact) {
      final contactMap = Map<String, String>.from(contact);
      final isFav = _provider.isFavorite(contactMap);

      if (isFav) {
        _provider.removeFromFavorites(contactMap);
      } else {
        _provider.addToFavorites(contactMap);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'First Name: ${widget.number['name']}',
                  style: TextStyle(fontSize: 24.0),
                ),
                Row(
                  children: [
                    Icon(Icons.phone),
                    Icon(Icons.messenger),
                    Icon(Icons.camera_outdoor_rounded),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Number: ${widget.number['number']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Organization: ${widget.number['org']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Toggle favorite status of the contact
                _toggleFav(widget.number);
              },
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Navigate to the AddNumberDialog page with contact info pre-filled
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNumberDialog(
                        // initialName: widget.number['name'] ?? '',
                        // initialNumber: widget.number['number'] ?? '',
                        // initialOrg: widget.number['org'] ?? '',
                        ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Add your share logic here
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Add your more_vert logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
