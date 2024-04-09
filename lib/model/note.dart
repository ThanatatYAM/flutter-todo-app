class Note {
  String? id;
  String? noteTitle;
  String? noteContent;

  Note({
    required this.id,
    required this.noteTitle,
    required this.noteContent,
  });

  static List<Note> noteList() {
    return [];
  }
}
