import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../../apimanager.dart';
import '../../usermanager.dart';

class HotelCreate extends StatefulWidget {
  final Function onCreate;

  HotelCreate({required this.onCreate});

  @override
  _HotelCreateState createState() => _HotelCreateState();
}

class _HotelCreateState extends State<HotelCreate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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

  Future<void> _createHotel() async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);
    if (_image != null) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final price = _priceController.text;
      final location = _locationController.text;
      // Use _image instead of _imageFile
      dynamic result = await apiManager.createHotel(
          _image!, name, description, price, location);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      widget.onCreate();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload an image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Hotel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _locationController,
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
              onPressed: _createHotel,
              child: Text('Create Hotel'),
            ),
          ],
        ),
      ),
    );
  }
}
