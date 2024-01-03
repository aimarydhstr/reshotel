import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'detailhotel.dart';
import 'createhotel.dart';
import 'edithotel.dart';
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

class MyHotel extends StatefulWidget {
  @override
  _MyHotelState createState() => _MyHotelState();
}

class _MyHotelState extends State<MyHotel> {
  List<Hotel> hotels = [];

  @override
  void initState() {
    super.initState();
    getHotels();
  }

  Future<void> getHotels() async {
    try {
      final apiManager = Provider.of<ApiManager>(context, listen: false);
      final response = await apiManager.getHotelDashboard();
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
        title: Text('Hotel Management'),
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
                            HotelDetails(hotel: hotels[index]),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Options'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelUpdate(
                                        hotel: hotels[index],
                                        onUpdate: getHotels,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await apiManager
                                      .deleteHotel(hotels[index].id.toString());
                                  await getHotels();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Data hotel berhasil dihapus"),
                                  ));
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelCreate(onCreate: getHotels),
            ),
          );
        },
        tooltip: 'Add Hotel',
        child: Icon(Icons.add),
      ),
    );
  }
}

String formatCurrency(String price) {
  final double parsedPrice = double.parse(price);
  final int wholeNumber = parsedPrice.toInt(); // Dapatkan bagian bilangan bulat

  final currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
  String formattedPrice = currencyFormatter.format(wholeNumber);

  formattedPrice = formattedPrice.replaceAll(',00', '');

  return formattedPrice;
}
