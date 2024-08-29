import 'package:flutter/material.dart';
import 'package:flutter_registration_app/pages/registration_list.dart';
import 'package:flutter_registration_app/pages/registration_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_registration_app/provider/images_provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (BuildContext context) => ImagesProvider() ,
        ),
      ],
      child: MaterialApp(
        title: 'Registeration App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'Registeration App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body:  TabBarView(
          children: [
           const RegistrationPage(),
            RegistrationListPage(),
          ],
        ),
        backgroundColor: Colors.blue[400],
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              text: 'Register Form',
            ),
            Tab(
              text: 'Registration List',
            ),
          ],
        ),
      ),
    );
    //}
  }
}
