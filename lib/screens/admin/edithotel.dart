import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../apimanager.dart';
import '../../usermanager.dart';
import 'gethotel.dart';

class HotelUpdate extends StatefulWidget {
  final Hotel hotel;
  final Function onUpdate;

  HotelUpdate({required this.hotel, required this.onUpdate});

  @override
  _HotelUpdateState createState() => _HotelUpdateState();
}

class _HotelUpdateState extends State<HotelUpdate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  Future<void> _updateHotel() async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);
    final response = await apiManager.updateHotel(
      widget.hotel.id.toString(),
      _image,
      nameController.text,
      descriptionController.text,
      priceController.text,
      locationController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response),
    ));
    widget.onUpdate();

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.hotel.name;
    descriptionController.text = widget.hotel.description;
    priceController.text = widget.hotel.price;
    locationController.text = widget.hotel.location;
  }

  @override
  Widget build(BuildContext context) {
    final apiManager = Provider.of<ApiManager>(context);
    final userManager = Provider.of<UserManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16),
            _image != null
                ? Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                  )
                : Container(),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateHotel,
              child: Text('Update Hotel'),
            ),
          ],
        ),
      ),
    );
  }
}
