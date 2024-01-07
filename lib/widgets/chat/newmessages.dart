import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../global.dart';


class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);  
  @override
  State<NewMessages> createState() => _NewMessageState();
  String get getImageUrl => '';
}

class _NewMessageState extends State<NewMessages> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user=await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text':_enteredMessage,
      'createdAt': Timestamp.now(),
      'userId':Email.email,
    });
    _controller.clear();
  }
  String imageName='';

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; // Variable to store the picked image file

  Future<void> _pickImageAndUpload_Gallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
     if (_imageFile != null) {
      File imageFile = File(_imageFile!.path);
      String uniqueId = Uuid().v4();
      String imageName = 'image_$uniqueId.jpg';
      // Upload the image to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('images').child(imageName);
      UploadTask uploadTask = ref.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot downloadURL = await uploadTask;
      imageUrl = await downloadURL.ref.getDownloadURL();

      // Save the image URL in Firestore
      await FirebaseFirestore.instance.collection('chat').add({
        'imageUrl': imageUrl,
        'ImagecreatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
  Future<void> _pickImageAndUpload_Camera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
     if (_imageFile != null) {
      File imageFile = File(_imageFile!.path);
      String uniqueId = Uuid().v4();
      String imageName = 'image_$uniqueId.jpg';
      // Upload the image to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('images').child(imageName);
      UploadTask uploadTask = ref.putFile(imageFile);

      // Get the download URL of the uploaded image
      TaskSnapshot downloadURL = await uploadTask;
      String imageUrl = await downloadURL.ref.getDownloadURL();
      // Save the image URL in Firestore
      await FirebaseFirestore.instance.collection('chat').add({
        'imageUrl': imageUrl,
        'ImagecreatedAt': FieldValue.serverTimestamp(),
      });
    }
  }
  late String imageUrl;
  final storage = FirebaseStorage.instance;
  @override
  void initState() {
    super.initState();
    // Set the initial value of imageUrl to an empty string
    imageUrl = '';
    //Retrieve the imge grom Firebase Storage
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    // Get the reference to the image file in Firebase Storage
    final ref = storage.ref().child('images').child(imageName);
    // Get teh imageUrl to download URL
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
    imageUrl;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top:8),
      padding:const EdgeInsets.all(8),
      child:Row(children: <Widget>[
        Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[200],
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Send a message...",
            border: InputBorder.none,
              suffixIcon: GestureDetector(
              onTap: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              child: SizedBox(
                width:70,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 237, 154, 9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.send_sharp, color: Colors.white),
                ),
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _enteredMessage = value;
            });
          },
        ),
      ),),
      SizedBox(
        width: 55,
        height: 56,
        child: Container(
          padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 154, 9),
                      borderRadius: BorderRadius.circular(20),
                    ),
          child: IconButton(
                  icon:const Icon(Icons.image,color: Colors.white,),
                  onPressed: _pickImageAndUpload_Gallery,
                  tooltip: 'Select Image',
                ),
        ),
      ),
      SizedBox(
        width: 55,
        height: 56,
        child: Container(
          padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 237, 154, 9),
                      borderRadius: BorderRadius.circular(20),
                    ),
          child: IconButton(
                  icon:const Icon(Icons.camera,color: Colors.white,),
                  onPressed: _pickImageAndUpload_Camera,
                  tooltip: 'Select Image',
                ),
        ),
      ),
      ],)
    );
  }
}