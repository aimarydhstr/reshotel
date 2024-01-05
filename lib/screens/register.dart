import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../apimanager.dart';
import 'package:provider/provider.dart';

class MyRegister extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  void _register(BuildContext context) async {
    final apiManager = Provider.of<ApiManager>(context, listen: false);

    final name = _nameController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    final repassword = _repasswordController.text;

    try {
      if (password != repassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password and Repeat Password harus sama.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else {
        await apiManager.register(name, username, password, repassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi Berhasil'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print('Registration failed. Error: $e');
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
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Register',
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
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.supervised_user_circle_sharp,
                      color: Colors.white,
                    ),
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
                child: TextField(
                  controller: _repasswordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Repeat Password',
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
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                    ),
                  ),
                  onPressed: () => _register(context),
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
                        // Perform login with Google here
                      },
                    ),
                  ),
                  ElevatedButton.icon(
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
                      // Perform login with Facebook here
                    },
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Container(
                child: Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: Text(
                    'SignIn',
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
        ),
      ),
    );
  }
}
