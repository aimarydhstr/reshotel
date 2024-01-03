import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hotel.dart';

class HotelDetail extends StatelessWidget {
  final Hotel hotel;

  HotelDetail({required this.hotel});

  @override
  Widget build(BuildContext context) {
    String formattedPrice = formatRupiah(hotel.price);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // Change back button color to black
        ), // Change background color to white
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            hotel.imageUrl,
            fit: BoxFit.cover,
            height: 200, // Atur tinggi sesuai kebutuhan Anda
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orangeAccent),
                    Text(hotel.rating.toString()),
                  ],
                ),
                Text('Rp. ${formattedPrice}'),
                Text('Location: ${hotel.location}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Ganti URL dengan URL peta hotel
                    launch('https://maps.google.com/?q=${hotel.location}');
                  },
                  child: Text('Open in Maps'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatRupiah(int amount) {
    // Format the number as Rupiah without using external library
    String formattedAmount = amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

    return formattedAmount;
  }
}
