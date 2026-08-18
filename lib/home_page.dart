import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  String _selectedIconName = 'Görev';
  DateTime _selectedDate = DateTime.now();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveTodoToFirebase() {
    if (_titleController.text.trim().isEmpty) return;

    _firestore.collection('todos').add({
      'title': _titleController.text.trim(),
      'subtitle': _subtitleController.text.trim(),
      'date': Timestamp.fromDate(_selectedDate),
      'iconName': _selectedIconName,
      'isDone': false,
    });

    _titleController.clear();
    _subtitleController.clear();
  }

  void _showAddTodoModal() {
    _selectedIconName = 'Görev';
    _selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Yeni Görev Ekle', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _selectedIconName,
                      decoration: const InputDecoration(labelText: 'Kategori (İkon)', border: OutlineInputBorder()),
                      items: AppIcons.icons.keys.map((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Row(
                            children: [
                              Icon(AppIcons.icons[key]),
                              const SizedBox(width: 10),
                              Text(key),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setModalState(() {
                          _selectedIconName = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Başlık', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _subtitleController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Alt Başlık / İçerik', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tarih: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
                        TextButton.icon(
                          icon: const Icon(Icons.calendar_today),
                          label: const Text("Tarih Seç"),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setModalState(() {
                                _selectedDate = picked;
                              });
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                        onPressed: () {
                          _saveTodoToFirebase();
                          Navigator.pop(context);
                        },
                        child: const Text('Kaydet', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerçek Zamanlı Todo'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('todos').orderBy('date').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu!'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('Henüz görev yok.\nSağ alttaki butona basarak ekle!'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final todo = Todo.fromMap(docs[index].id, data);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Icon(
                    AppIcons.icons[todo.iconName] ?? Icons.task_alt,
                    size: 35,
                    color: todo.isDone ? Colors.grey : Colors.blueAccent,
                  ),

                  title: Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: todo.isDone ? TextDecoration.lineThrough : null, // Üstünü çizme efekti
                      color: todo.isDone ? Colors.grey : Colors.black,
                    ),
                  ),

                  subtitle: Text(
                    "${todo.subtitle}\nSon Tarih: ${todo.date.day}/${todo.date.month}/${todo.date.year}",
                    style: TextStyle(
                      color: todo.isDone ? Colors.grey : Colors.black87,
                    ),
                  ),

                  trailing: Checkbox(
                    value: todo.isDone,
                    activeColor: Colors.green,
                    onChanged: (bool? newValue) {
                      _firestore.collection('todos').doc(todo.id).update({
                        'isDone': newValue,
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoModal,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}