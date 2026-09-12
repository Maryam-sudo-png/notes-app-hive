import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'note_model.dart';
import 'wood_background.dart';
import 'paper_card.dart';
import 'login_screen.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({super.key});

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  final Box<Note> notesBox = Hive.box<Note>('notesBox');
  String _searchQuery = '';

  void _showNoteDialog({Note? note, int? index}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(note == null ? 'New Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: 4),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;
              final newNote = Note(
                title: titleController.text.trim(),
                content: contentController.text.trim(),
                createdAt: DateTime.now(),
              );
              setState(() {
                if (index == null) {
                  notesBox.add(newNote);
                } else {
                  notesBox.putAt(index, newNote);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() => notesBox.deleteAt(index));
  }

  void _deleteAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete all notes?'),
        content: const Text('Ye action wapas nahi ho sakta.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              notesBox.clear();
              Navigator.pop(context);
            },
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  void _searchNotes() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _searchQuery);
        return AlertDialog(
          title: const Text('Search Notes'),
          content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Title contains...')),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _searchQuery = '');
                Navigator.pop(context);
              },
              child: const Text('Clear'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _searchQuery = controller.text.trim());
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WoodBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    const Text('My Notes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.edit, color: Colors.white), tooltip: 'New Note', onPressed: () => _showNoteDialog()),
                    IconButton(icon: const Icon(Icons.search, color: Colors.white), tooltip: 'Search', onPressed: _searchNotes),
                    IconButton(icon: const Icon(Icons.delete_forever, color: Colors.white), tooltip: 'Delete All', onPressed: _deleteAll),
                    IconButton(icon: const Icon(Icons.logout, color: Colors.white), tooltip: 'Logout', onPressed: _logout),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: notesBox.listenable(),
                  builder: (context, Box<Note> box, _) {
                    final notes = box.values.toList().asMap().entries.where((e) =>
                        _searchQuery.isEmpty || e.value.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

                    if (notes.isEmpty) {
                      return const Center(child: Text('No notes found', style: TextStyle(color: Colors.white70, fontSize: 16)));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: notes.length,
                      itemBuilder: (context, i) {
                        final index = notes[i].key;
                        final note = notes[i].value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: PaperCard(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      if (note.content.isNotEmpty) ...[
                                        const SizedBox(height: 6),
                                        Text(note.content, maxLines: 3, overflow: TextOverflow.ellipsis),
                                      ],
                                      const SizedBox(height: 6),
                                      Text(DateFormat('dd MMM yyyy, hh:mm a').format(note.createdAt),
                                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                                IconButton(icon: const Icon(Icons.edit_outlined, size: 20), onPressed: () => _showNoteDialog(note: note, index: index)),
                                IconButton(icon: Icon(Icons.delete_outline, size: 20, color: Colors.red.shade300), onPressed: () => _deleteNote(index)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}