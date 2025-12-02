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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F8F6),

        title: Text('Home Page', style: TextStyle(color: Color(0xFF43334C))),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // color: Colors.white.withOpacity(0.8),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Color(0xFFF9F8F6).withOpacity(0.5),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/image/profile.jpg'),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Rendy Kamaluddin',
                    style: TextStyle(
                      color: Color(0xFF43334C),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    '714230030',
                    style: TextStyle(
                      color: Color(0xFF43334C),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 2),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoTile("Kelas", "D4-TI-3A"),
                        infoTile("Program Studi", "Teknik Informatika"),
                        infoTile("Semester", "5"),
                        infoTile("Mata Kuliah", "Pemrograman IV"),
                      ],
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

  Widget infoTile(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$title : ",
              style: TextStyle(
                color: Color(0xFF43334C),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(value, style: TextStyle(color: Color(0xFF7B6D6D))),
          ],
        ),
      ),
    );
  }
}
