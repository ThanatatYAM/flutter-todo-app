import 'package:flutter/material.dart';
import '../model/note.dart';
import '../constants/colors.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final onDeleteItem;

  const NoteItem({
    Key? key,
    required this.note,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.white,
          title: Text(note.noteTitle!),
          subtitle: Text(note.noteContent!),
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 35,
            width: 50,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                // print('Clicked on delete icon');
                onDeleteItem(note.id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
