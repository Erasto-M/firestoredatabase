import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main()async{
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(controller: controller,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 20),
            child: IconButton(
              color: Colors.green,
                onPressed: (){
              final name = controller.text;
              createUser(name:name);
            },
                icon: Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
  Future createUser({required String name}) async{
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
    final json = {
      'name': name,
      'age' : 21,
      'birthday' : DateTime(2002,5,23),
    };
    await docUser.set(json);
  }
}
