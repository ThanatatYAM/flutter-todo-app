import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/note.dart';
import '../widgets/note_item.dart';

class MyNote extends StatefulWidget {
  const MyNote({super.key});

  @override
  State<MyNote> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyNote> {
  @override
  final notesList = Note.noteList();
  List<Note> _foundNote = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    _foundNote = notesList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Expanded(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                  TextField(
                      controller: contentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Content',
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 10,
                      right: 10,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        'Create Note',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            contentController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("ข้อผิดพลาด"),
                                content: Text("กรุณาใส่ข้อมูลครบ"),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          addNoteItems(
                              titleController.text, contentController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: tdBlue,
                        minimumSize: Size(30, 50),
                        elevation: 10,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (Note notes in _foundNote.reversed)
                    NoteItem(
                      note: notes,
                      onDeleteItem: _deleteNoteItem,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Row(
              children: [
                Icon(Icons.note_alt_outlined),
                Text(" NOTE"),
              ],
            ),
          ],
        ));
  }

  void addNoteItems(String title, String content) {
    setState(() {
      notesList.add(Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        noteTitle: title,
        noteContent: content,
      ));
    });
    titleController.clear();
    contentController.clear();
  }

  void _deleteNoteItem(String id) {
    setState(() {
      notesList.removeWhere((item) => item.id == id);
    });
  }
}
