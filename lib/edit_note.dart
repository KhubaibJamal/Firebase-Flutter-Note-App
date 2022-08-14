import 'package:flutter/material.dart';
import 'package:flutter_fire_note_app/database_services.dart';

class EditNote extends StatelessWidget {
  String? id;
  String? title;
  String? memo;
  EditNote({Key? key, this.id, this.title, this.memo}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void edit() {
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
        DatabaseServices.editNote(
            id!, titleController.text, memoController.text);
        // titleController.clear();
        // memoController.clear();
        Navigator.pop(context);
      }
    }

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
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "$title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  onTap: () {
                    titleController.text = "$title";
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: memoController,
                  maxLines: 7,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "$memo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onTap: () {
                    memoController.text = "$memo";
                  },
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
                    onPressed: edit,
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
