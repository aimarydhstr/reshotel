import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'detail.dart';
import 'hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    String formattedPrice = formatRupiah(hotel.price);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetail(hotel: hotel),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              hotel.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orangeAccent),
                      Text(hotel.rating.toString()),
                    ],
                  ),
                  Text('Rp. ${formattedPrice}'),
                  Text('${hotel.location}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String formatRupiah(int amount) {
    // Format the number as Rupiah without using external library
    String formattedAmount = amount.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.'
    );

    return formattedAmount;
  }
}
