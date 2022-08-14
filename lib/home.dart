import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_note_app/add_note.dart';
import 'package:flutter_fire_note_app/edit_note.dart';
import 'database_services.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: db.collection("notes").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final response = snapshot.data!.docs[index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.delete, color: Colors.white),
                            Text('Move to trash',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Delete Confirmation",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                              "Are you sure you want to delete this item?",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (DismissDirection direction) {
                      DatabaseServices.deleteNote(response.id);
                    },
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          "${response['title']}",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          const Padding(padding: EdgeInsets.only(bottom: 10.0)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "${response['memo']}",
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        ],
                        leading: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditNote(
                                            id: response.id,
                                            title: response['title'],
                                            memo: response['memo'],
                                          )));
                            },
                            icon: const Icon(Icons.edit)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ));
            }
          },
        ),
      ),
    );
  }
}
