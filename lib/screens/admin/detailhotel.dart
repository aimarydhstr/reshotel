import 'package:flutter/material.dart';
import 'gethotel.dart';
import 'package:provider/provider.dart';
import '../../apimanager.dart';
import '../../usermanager.dart';
import 'package:intl/intl.dart';
import 'gethotel.dart';
import 'edithotel.dart';

class HotelDetails extends StatelessWidget {
  final Hotel hotel;

  HotelDetails({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context);
    final userManager = Provider.of<UserManager>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200, // Adjust the height as needed
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('http://192.168.32.128/reshotel_api/uploads/${hotel.file_name}'), // Replace with your image URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey, // Adjust color as needed
                                ),
                                SizedBox(width: 4), // Adjust spacing as needed
                                Text(
                                  '${hotel.location}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${formatCurrency(hotel.price)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 56),
                        Text(
                          'Deskripsi Hotel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '${hotel.description}',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatCurrency(String price) {
  final double parsedPrice = double.parse(price);
  final int wholeNumber = parsedPrice.toInt();
  final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
  String formattedPrice = currencyFormatter.format(wholeNumber);
  formattedPrice = formattedPrice.replaceAll(',00', '');

  return formattedPrice;
}
