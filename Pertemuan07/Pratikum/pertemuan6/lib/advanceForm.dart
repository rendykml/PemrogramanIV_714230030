import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class Advanceform extends StatefulWidget {
  const Advanceform({super.key});

  @override
  State<Advanceform> createState() => _AdvanceformState();
}

class _AdvanceformState extends State<Advanceform> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  String? _dataFile;
  File? _imageFile;

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;

    if (file.extension == 'jpg' || 
        file.extension == 'png' || 
        file.extension == 'jpeg'
    ) {
      setState(() {
        _imageFile = File(file.path!);
      });
    }

    setState((){
      _dataFile = file.name;
    });

    _openFile(file);
  }

  void _openFile(PlatformFile file){
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Widget'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildDatePicker(),
            const SizedBox(height: 20),
            buildColorPicker(context),
            const SizedBox(height: 20),
            buildFilePicker(context),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date'),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectDate != null) {
                    _dueDate = selectDate;
                  }
                });
              },
            ),
          ],
        ),
        Text(DateFormat('dd/MM/yyyy').format(_dueDate)),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Picker'),
        const SizedBox(height: 10),
        Container(height: 100, width: double.infinity, color: _currentColor),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _currentColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Pick your color'),
                    content: Column(
                      children: [
                        ColorPicker(
                          pickerColor: _currentColor,
                          onColorChanged: (color) {
                            setState(() {
                              _currentColor = color;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          return Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Select Color'),
          ),
        ),
      ],
    );
  }

  Widget buildFilePicker(BuildContext context) {
    return Column(
      children: [
        const Text('Pick File'),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {
              _pickFile();
            },
            child: Text('Pick and Open File'),
          ),
        ),
        if (_dataFile != null) Text('File Name: $_dataFile'),
        const SizedBox(height: 10),
        if(_imageFile != null)
          Image.file(_imageFile!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,)
      ],
    );
  }
}
