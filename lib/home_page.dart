import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchQuery = new TextEditingController();
  Timer? _debounce;
  String searchText = "";

  List<String> _data = [];
  List<String> _filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debounce Searching"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _searchQuery,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Search here',
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredData[index].toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: _filteredData.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

// This is called whenever user inputs on text box
  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (this.searchText != _searchQuery.text) {
        // Protect starting immediately
        _filteredData = this._data;
        setState(() {
          this._filteredData = this
              ._data
              .where(
                // Convert item over lowercase with contain for user input
                (item) => item.toString().toLowerCase().contains(
                      _searchQuery.text.toString().toLowerCase(),
                    ),
              )
              .toList();

          print(this._filteredData.length);
        });
      }
      this.searchText = _searchQuery.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);

    _data.add("");
    _data.add("Alabama");
    _data.add("Alaska");
    _data.add("Arizona");
    _data.add("Arkansas");
    _data.add("California");
    _data.add("Colorado");
    _data.add("Connecticut");
    _data.add("Delaware");
    _data.add("Florida");
    _data.add("Georgia");
    _data.add("Hawaii");
    _data.add("Idaho");
    _data.add("Illinois");
    _data.add("Indiana");
    _data.add("Iowa");
    _data.add("Kansas");
    _data.add("Kentucky");
    _data.add("Louisiana");
    _data.add("Maine");
    _data.add("Maryland");
    _data.add("Montana");
    _data.add("Nebraska");
    _data.add("Nevada");
    _data.add("New Hampshire");
    _data.add("New Jersey");
    _data.add("New Mexico");
    _data.add("Burundi");
    _data.add("New York");
    _data.add("North Carolina");
    _data.add("North Dakota");
    _data.add("Ohio");
    _data.add("Oklahoma");
    _data.add("Oregon");
    _data.add("Pennsylvania");
    _data.add("Rhode Island");
    _data.add("South Carolina");
    _data.add("South Dakota");
    _data.add("Tennessee");
    _data.add("Texas");
    _data.add("Utah");
    _data.add("Vermont");
    _data.add("Virginia");
    _data.add("Washington");
    _data.add("Webst Virginia");
    _data.add("Wisconsin");
    _data.add("Wyoming");

    this._filteredData = _data;
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
