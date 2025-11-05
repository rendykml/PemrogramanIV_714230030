import 'package:flutter/material.dart';

void main() {
  runApp(const ColumnRowApp());
}

class ColumnRowApp extends StatelessWidget {
  const ColumnRowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Pertemuan 4',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tugas Pertemuan 4'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue),
                child: const Text(
                  'Box 1',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 21),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.red),
                    child: const Text(
                      'Box 2',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.green),
                    child: const Text(
                      'Box 3',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
