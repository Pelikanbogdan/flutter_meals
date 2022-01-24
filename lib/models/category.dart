import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
  static Color _parseColor(int colorValue) {
    return Color(colorValue).withOpacity(1.0);
  }

  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      color: _parseColor(snapshot['color']),
      title: snapshot['title'],
      id: snapshot['id'],
    );
  }
}
