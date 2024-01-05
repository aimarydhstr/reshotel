import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../apimanager.dart';
import '../usermanager.dart';
import 'package:provider/provider.dart';

class MyLogin extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _authenticate(BuildContext context) async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await apiManager.authenticate(username, password);
      final token = response['token'];
      final userRole = response['role'];
      userManager.setAuthToken(token);

      if (userRole == 'User') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Berhasil'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else if (userRole == 'Admin') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Berhasil'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/hotel');
      }
    } catch (e) {
      print('Authentication failed. Error: $e');
      // Handle authentication failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.verified_user,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              width: double.infinity,
              child: ElevatedButton(
                // Ganti warna latar belakang sesuai kebutuhan
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.blue, fontSize: 18.0),
                  ),
                ),
                onPressed: () => _authenticate(context),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'OR',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: ElevatedButton.icon(
                    // Ganti warna latar belakang sesuai warna Google
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    icon: Icon(FontAwesomeIcons.google, color: Colors.white),
                    label: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Google',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                  ),
                ),
                ElevatedButton.icon(
                  // Ganti warna latar belakang sesuai warna Facebook
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
                  label: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                ),
              ],
            ),
            SizedBox(height: 50.0),
            Container(
              child: Text(
                'Dont have an account?',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
