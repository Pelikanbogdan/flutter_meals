import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meals/models/categories_model.dart';
import 'package:flutter_meals/widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }
        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot docSnap = snapshot.data!.docs[index];
            final category = Category.fromSnapshot(docSnap);
            return CategoryItem(
                title: category.title,
                bgcolor: category.color,
                id: category.id);
          },
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        );
      },
    );
  }
}
