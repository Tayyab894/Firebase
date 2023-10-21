import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/utils/utility.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              maxLines: 4,
              //  maxLength: 100,
              controller: postController,

              decoration: InputDecoration(
                hintText: "What is in your mind?",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
                loading: loading,
                title: "Add",
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    "title": postController.text.toString(),
                    "id": id,
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().ToastMessage("Post Added");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().ToastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }


}
