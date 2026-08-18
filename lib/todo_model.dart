import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppIcons {
  static const Map<String, IconData> icons = {
    'Görev': Icons.task_alt,
    'Ev': Icons.home,
    'İş': Icons.work,
    'Alışveriş': Icons.shopping_cart,
    'Spor': Icons.sports_gymnastics,
    'Eğitim': Icons.school,
    'Sağlık': Icons.local_hospital,
    'Eğlence': Icons.movie,
    'Seyahat': Icons.flight,
    'Diğer': Icons.star,
  };
}

class Todo {
  String id;
  String title;
  String subtitle;
  DateTime date;
  String iconName;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.iconName,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': Timestamp.fromDate(date),
      'iconName': iconName,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(String docId, Map<String, dynamic> map) {
    return Todo(
      id: docId,
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      iconName: map['iconName'] ?? 'Görev',
      isDone: map['isDone'] ?? false,
    );
  }
}