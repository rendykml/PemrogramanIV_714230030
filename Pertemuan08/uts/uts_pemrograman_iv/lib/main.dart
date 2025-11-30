import 'package:flutter/material.dart';
import 'package:uts_pemrograman_iv/bottomNavbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Contacts',
      theme: ThemeData(useMaterial3: false),
      home: DynamicBottomNavbar(),
    );
  }
}

class MyInput extends StatefulWidget {
  const MyInput({super.key});

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  //Font Color
  //1B3C53 Biru Tua
  //234C6A Biru Sedang
  //456882 Biru Terang
  //E3E3E3 Abu-Abu Muda
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F8F6),
        // iconTheme: IconThemeData(color: Color(0xFF43334C)),
        title: Text('Home Page', style: TextStyle(color: Color(0xFF43334C))),
      ),
      body: Container(
        color: Color(0xFFEFE9E3),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 15, 15, 15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 236, 236),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    backgroundImage: AssetImage('assets/image/profile.jpg'),
                  ),

                  SizedBox(height: 16),
                  Text(
                    'Rendy Kamaluddin',
                    style: TextStyle(
                      color: Color.fromARGB(255, 123, 109, 109),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),
                  Text(
                    '714230030',
                    style: TextStyle(
                      color: Color.fromARGB(255, 123, 109, 109),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
