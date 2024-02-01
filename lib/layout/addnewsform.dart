import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:latihan_state_management_bloc/bloc/addnews_bloc.dart';
import 'package:flutter/material.dart';

class AddNewsForm extends StatefulWidget {
  const AddNewsForm({super.key});

  @override
  State<AddNewsForm> createState() => _AddNewsFormState();
}

class _AddNewsFormState extends State<AddNewsForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                    setState(() {
                      dateController.text = formattedDate;
                    });
                  }
                },
              ),
              pickedImage != null
                  ? SizedBox(
                      height: 300,
                      child: Image.file(
                        pickedImage!,
                        fit: BoxFit.cover,
                      ))
                  : const SizedBox.shrink(),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg'],
                  );

                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      pickedImage = File(result.files.single.path!);
                    });
                  }
                },
                child: const Text('Pick Image (.jpg)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (pickedImage == null || titleController.text == '' || contentController.text == '' || dateController.text == '') {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('No Image'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Silahka Lengkapi Data'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'),
                          )
                        ],
                      ),
                    );
                  } else {
                    final title = titleController.text;
                    final content = contentController.text;
                    final date = dateController.text;
                    final image = pickedImage;

                    context.read<AddnewsBloc>().add(
                          AddnewsInitial(
                            title: title,
                            content: content,
                            date: date,
                            image: image!,
                          ),
                        );
                  }
                },
                child: const Text('Add News'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
