import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'detail.dart';
import '../../apimanager.dart';
import '../../usermanager.dart';
import 'package:intl/intl.dart';

class Hotel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String location;
  final String file_name;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.file_name,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      location: json['location'],
      file_name: json['file_name'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchBarVisible = false;
  TextEditingController searchController = TextEditingController();
  List<Hotel> hotels = [];

  @override
  void initState() {
    super.initState();
    getHotels();
  }

  Future<void> getHotels() async {
    try {
      final apiManager = Provider.of<ApiManager>(context, listen: false);
      final response = await apiManager.getHotels();
      setState(() {
        hotels = response.map((json) => Hotel.fromJson(json)).toList();
      });
    } catch (e) {
      print('Error getting hotels: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context);
    final userManager = Provider.of<UserManager>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: isSearchBarVisible
            ? TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search hotels...',
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: Colors.black,
          ),
        )
            : Text(
          'HotelApp',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;
                if (!isSearchBarVisible) {
                  searchController.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              apiManager.logout();
              userManager.setAuthToken(null);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout Berhasil'),
                ),
              );
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 16),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75,
            ),
            itemCount: hotels.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Details(hotel: hotels[index]),
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    // Add this widget
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.5,
                          child: Image.network(
                            'http://192.168.32.128/reshotel_api/uploads/${hotels[index].file_name}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              Text(hotels[index].name),
                              SizedBox(height: 5),
                              Text('${formatCurrency(hotels[index].price)}'),
                              SizedBox(height: 16),
                              Text('${hotels[index].location}'),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
