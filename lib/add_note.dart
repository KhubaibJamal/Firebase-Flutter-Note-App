import 'package:flutter/material.dart';
import 'package:flutter_fire_note_app/database_services.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();

  TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTES"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Enter title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: memoController,
                  maxLines: 7,
                  minLines: 1,
                  decoration: InputDecoration(
                      hintText: "Enter memo",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50.0))),
                    onPressed: add,
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    setState(() {
      if (titleController.text.isEmpty && memoController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Error',
                  style: TextStyle(fontSize: 25.0),
                ),
                content: const Text(
                  'Please fill the fields',
                  style: TextStyle(fontSize: 20.0),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Ok",
                        style: TextStyle(fontSize: 20.0),
                      )),
                ],
              );
            });
      } else {
        DatabaseServices.addNotes(titleController.text, memoController.text);
        titleController.clear();
        memoController.clear();
        Navigator.pop(context);
      }
    });
  }
}
