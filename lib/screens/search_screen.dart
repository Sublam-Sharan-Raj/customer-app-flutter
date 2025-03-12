import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> allSuggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Guava',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
  ];

  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterSuggestions);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterSuggestions);
    searchController.dispose();
    super.dispose();
  }

  void _filterSuggestions() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredSuggestions = allSuggestions
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          border: Border.all(color: Colors.grey.shade400), // Border color
        ),
        child: TextField(
          // focusNode: focusNode,
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search InstaCloset",

            hintStyle:
                TextStyle(color: Colors.grey.shade600), // Hint text style
            border: InputBorder.none, // No border
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0), // Padding for icon
              child: Icon(
                Icons.search,
                color: Colors.grey.shade600, // Icon color
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0), // Vertical padding
          ),
        ),
      )),
      body: filteredSuggestions.isEmpty
          ? Center(
              child: Text(
                'No suggestions available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggestions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                          ),
                          title: Text(filteredSuggestions[index]),
                          onTap: () {
                            // Optionally handle suggestion selection
                            searchController.text = filteredSuggestions[index];
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
