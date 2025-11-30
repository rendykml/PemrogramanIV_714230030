import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:io';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerName.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    const String expression = "^[0-9]{8,13}$";

    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!regExp.hasMatch(value)) {
      return "Please enter the valid phone number 62 at first(min 8 and max 13)!";
    }
    return null;
  }

  String? _validateName(String? value) {
    const String expression = "^[A-Z][a-z]+( [A-Za-z]+)+";
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    if (!regExp.hasMatch(value)) {
      return 'Please enter your valid name (min 2 words, first character capitalized, no character word)!';
    }
    return null;
  }

  // DateTime _dueDate = DateTime.now();
  // final currentDate = DateTime.now();
  // Color _currentColor = const Color.fromARGB(255, 167, 122, 53);
  // String? _dataFile;
  // File? _imageFile;

  // void _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;

  //   final file = result.files.first;

  //   if (file.extension == 'jpg' ||
  //       file.extension == 'png' ||
  //       file.extension == 'jpeg') {
  //     setState(() {
  //       _imageFile = File(file.path!);
  //     });
  //   }

  //   setState(() {
  //     _dataFile = file.name;
  //   });

  //   _openFile(file);
  // }

  // void _openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9F8F6),
        title: const Text(
          'List Contacts',
          style: TextStyle(color: Color(0xFF43334C)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerPhoneNumber,
                    validator: _validatePhoneNumber,
                    cursorColor: Color(0xFF1B3C53),
                    decoration: const InputDecoration(
                      hintText: 'Write your phone number here...',
                      labelText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1B3C53),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1B3C53),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerName,
                    validator: _validateName,
                    cursorColor: Color(0xFF1B3C53),
                    decoration: const InputDecoration(
                      hintText: 'Write your name here...',
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1B3C53),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1B3C53),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerDate,
                    cursorColor: Color(0xFF1B3C53),
                    decoration: const InputDecoration(
                      hintText: 'Put your date here...',
                      labelText: 'Date',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1B3C53),
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF1B3C53),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    } else {}
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //   Widget buildDatePicker() {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('Date'),
  //             TextButton(
  //               child: const Text('Select'),
  //               onPressed: () async {
  //                 final selectDate = await showDatePicker(
  //                   context: context,
  //                   initialDate: currentDate,
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime(currentDate.year + 5),
  //                 );
  //                 setState(() {
  //                   if (selectDate != null) {
  //                     _dueDate = selectDate;
  //                   }
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         Text(DateFormat('dd/MM/yyyy').format(_dueDate)),
  //       ],
  //     );
  //   }

  //   Widget buildColorPicker(BuildContext context) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text('Color Picker'),
  //         const SizedBox(height: 10),
  //         Container(height: 100, width: double.infinity, color: _currentColor),
  //         const SizedBox(height: 10),
  //         Center(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(backgroundColor: _currentColor),
  //             onPressed: () {
  //               showDialog(
  //                 context: context,
  //                 builder: (context) {
  //                   return AlertDialog(
  //                     title: const Text('Pick your color'),
  //                     content: Column(
  //                       children: [
  //                         ColorPicker(
  //                           pickerColor: _currentColor,
  //                           onColorChanged: (color) {
  //                             setState(() {
  //                               _currentColor = color;
  //                             });
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                     actions: [
  //                       TextButton(
  //                         child: const Text('Save'),
  //                         onPressed: () {
  //                           return Navigator.of(context).pop();
  //                         },
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             },
  //             child: const Text('Select Color'),
  //           ),
  //         ),
  //       ],
  //     );
  //   }

  //   Widget buildFilePicker(BuildContext context) {
  //     return Column(
  //       children: [
  //         const Text('Pick File'),
  //         const SizedBox(height: 10),
  //         Center(
  //           child: ElevatedButton(
  //             onPressed: () {
  //               _pickFile();
  //             },
  //             child: Text('Pick and Open File'),
  //           ),
  //         ),
  //         if (_dataFile != null) Text('File Name: $_dataFile'),
  //         const SizedBox(height: 10),
  //         if (_imageFile != null)
  //           Image.file(
  //             _imageFile!,
  //             height: 200,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //       ],
  //     );
  //   }
}
