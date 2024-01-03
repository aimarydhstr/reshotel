import 'package:flutter/material.dart';
import 'gethotel.dart';
import 'package:provider/provider.dart';
import '../../apimanager.dart';
import '../../usermanager.dart';

class HotelDetails extends StatelessWidget {
  final Hotel hotel;

  HotelDetails({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context);
    final userManager = Provider.of<UserManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${hotel.description}'),
            Text('Price: ${hotel.price}'),
            Text('Location: ${hotel.location}'),
            SizedBox(height: 16),
            // Additional details or images can be displayed here
          ],
        ),
      ),
    );
  }
}
