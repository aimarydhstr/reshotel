// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'hotelcard.dart';
// import 'hotel.dart';
//
// class HomeScreen extends StatefulWidget {
//   final List<Hotel> hotels;
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   bool isSearchBarVisible = false;
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: isSearchBarVisible
//             ? TextField(
//           controller: searchController,
//           decoration: InputDecoration(
//             hintText: 'Search hotels...',
//             hintStyle: TextStyle(
//               color: Colors.black,
//             ),
//             border: InputBorder.none,
//           ),
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         )
//             : Text(
//           'HotelApp',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {
//               setState(() {
//                 isSearchBarVisible = !isSearchBarVisible;
//                 if (!isSearchBarVisible) {
//                   searchController.clear();
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.hotels.length,
//               itemBuilder: (context, index) {
//                 return HotelCard(hotel: widget.hotels[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
