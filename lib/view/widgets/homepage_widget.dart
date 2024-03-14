import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/controller/provider/profidermanager.dart';

class AddNumberDialog extends StatefulWidget {
  @override
  State<AddNumberDialog> createState() => _AddNumberDialogState();
}

class _AddNumberDialogState extends State<AddNumberDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<NumberProvider>(context, listen: false).loadNumbers();
    });
  }

  Widget build(BuildContext context) {
    return Consumer<NumberProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 30, right: 20),
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
                  ],
                ),
              ),
              SizedBox(height: 50),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            onChanged: (value) {
                              provider.name = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Number',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            onChanged: (value) {
                              provider.number = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Organization',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            onChanged: (value) {
                              provider.organization = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.saveNumber(
                            provider.name,
                            provider.number,
                            provider.organization,
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
