import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/home.dart';
import 'screens/admin/gethotel.dart';
import 'screens/detail.dart';
import 'package:provider/provider.dart';
import 'apimanager.dart';
import 'usermanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiManager apiManager =
      ApiManager(baseUrl: 'http://192.168.32.128/reshotel_api');
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: apiManager),
        ChangeNotifierProvider<UserManager>(create: (_) => UserManager()),
      ],
      child: MaterialApp(
        title: 'HotelApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Google Sans',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => MyLogin(),
          '/register': (context) => MyRegister(),
          '/home': (context) => HomeScreen(),
          '/hotel': (context) => MyHotel(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
