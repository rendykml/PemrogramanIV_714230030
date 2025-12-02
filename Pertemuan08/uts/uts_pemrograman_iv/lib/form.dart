import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  PlatformFile? _pickedFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();
  TextEditingController _controllerImage = TextEditingController();
  final List<Map<String, dynamic>> _myDataList = [];
  Map<String, dynamic>? editedData;
  Color _selectedColor = const Color.fromARGB(255, 243, 243, 243);

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerName.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  void _addData() {
    final data = {
      'name': _controllerName.text,
      'phone number': _controllerPhoneNumber.text,
      'date': _controllerDate.text,
      'image': _controllerImage.text,
      'color': _selectedColor.value,
    };
    setState(() {
      if (editedData != null) {
        // Jika editedData ada, maka kita sedang dalam mode edit
        // Sehingga kita perlu memperbarui data yang sedang diedit
        editedData!['name'] = data['name'];
        editedData!['phone number'] = data['phone number'];
        editedData!['date'] = data['date'];
        editedData!['image'] = data['image'];
        editedData!['color'] = data['color'];
        // Kosongkan kembali editedData setelah proses edit selesai
        editedData = null;
      } else {
        // Jika editedData kosong, maka kita sedang dalam mode insert
        _myDataList.add(data);
      }
      _controllerName.clear();
      _controllerDate.clear();
      _controllerImage.clear();
      _controllerPhoneNumber.clear();
      _selectedColor = const Color.fromARGB(255, 243, 243, 243);
    });
  }

  void _editData(Map<String, dynamic> data) {
    setState(() {
      _controllerName.text = data['name'];
      _controllerDate.text = data['date'];
      _controllerPhoneNumber.text = data['phone number'];
      _controllerImage.text = data['image'];
      _selectedColor = Color(data['color']);
      editedData = data;
    });
  }

  void _deleteData(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myDataList.remove(data);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _pickedFile = result.files.first;
        _controllerImage.text = _pickedFile!.path!;
      });
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }

    return null;
  }

  String? _validatePhoneNumber(String? value) {
    final RegExp regExp = RegExp(r'^62[0-9]{8,13}$');

    if (value!.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!regExp.hasMatch(value)) {
      return "Please enter the valid phone number 62 at first(min 8 and max 13)!";
    }
    return null;
  }

  String? _validateName(String? value) {
    const String expression = r'^[A-Z][a-z]+( [A-Za-z]+)+$';
    final RegExp regExp = RegExp(expression);

    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    if (!regExp.hasMatch(value)) {
      return 'Please enter your valid name (min 2 words, first character capitalized, no character word)!';
    }
    return null;
  }

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
      body: Container(
        color: Color.fromARGB(255, 245, 245, 245),
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
                    validator: _validateDate,
                    readOnly: true,
                    cursorColor: Color(0xFF1B3C53),

                    decoration: InputDecoration(
                      hintText: 'Put your date here...',
                      labelText: 'Date',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF1B3C53),
                      ),
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

                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

                        setState(() {
                          _controllerDate.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Image :",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF43334C),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B3C53),
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Choose Image"),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerImage,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Image Path",
                      hintText: "Image file path will appear here",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Color :",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF43334C),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Pick a Color"),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: _selectedColor,
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          _selectedColor = color;
                                        });
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Done"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B3C53),
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Pick Color"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  height: 25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black26),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Data has been saved'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please complete the form'),
                        ),
                      );
                    }
                  },
                  child: Text(editedData != null ? "Update" : "Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 123, 109, 109),
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'List Data',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _myDataList.length,
                    itemBuilder: (context, index) {
                      final data = _myDataList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  data['image'] != null && data['image'] != ""
                                  ? FileImage(File(data['image']))
                                  : null,
                              child:
                                  data['image'] == null || data['image'] == ""
                                  ? Icon(Icons.person, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name'] ?? ''),
                                  Text(data['phone number'] ?? ''),
                                  Text(data['date'] ?? ''),
                                  SizedBox(height: 4),
                                  Container(
                                    height: 4,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Color(data['color']),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _editData(data);
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _deleteData(data);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
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
