import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class DatabaseServices {
  static Future<void> addNotes(String title, String memo) async {
    await db
        .collection("notes")
        .add({"title": title, "memo": memo})
        .whenComplete(() => null)
        .catchError((e) {
          print('$e');
        });
  }

  static Future<void> deleteNote(String id) async {
    await db.collection('notes').doc(id).delete();
  }

  static Future<void> editNote(String id, String title, String memo) async {
    await db.collection('notes').doc(id).update({'title': title, 'memo': memo});
  }
}
