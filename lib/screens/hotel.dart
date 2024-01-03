import 'package:flutter/material.dart';

class Hotel {
  final String name;
  final String imageUrl;
  final double rating;
  final int price;
  final String location;

  Hotel({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.location,
  });
}
