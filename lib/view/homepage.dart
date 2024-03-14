import 'package:contact_book/view/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/controller/provider/profidermanager.dart';
import 'package:contact_book/view/detail_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _toggleFav(Map<String, String> contact) {
    Provider.of<NumberProvider>(context, listen: false).toggleFavorite(contact);
  }

  late NumberProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<NumberProvider>(context, listen: false);
    _provider.loadNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<NumberProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 40, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/p.jpg'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nareen Asad',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () {},
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNumberDialog(),
                                ),
                              );
                            },
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '⭐ Favourites',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildFavs(), // Display favorite numbers
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        '💾 Saved Numbers',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildNumbers(), // Display saved numbers
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNumbers() {
    return Consumer<NumberProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _provider.numbers.map((contact) {
            bool isFavorite = _provider.isFavorite(contact);
            return ListTile(
              leading: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  _toggleFav(contact);
                },
              ),
              title: Text(
                contact['name']!,
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Make text bold
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  _provider.removeNumber(contact);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(number: contact),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFavs() {
    return Consumer<NumberProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _provider.favorites.map((contact) {
            return ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: Text(
                contact['name']!,
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Make text bold
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(number: contact),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
