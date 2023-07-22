
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserName {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getUserId() async {
    final User? user = await auth.currentUser;
    final userId = user?.uid.toString();
    return userId;
  }
  CollectionReference userData = FirebaseFirestore.instance.collection('user');

  String userName = " ";

  Future<String> get_name() async{
    DocumentSnapshot snapshot = await userData.doc(await getUserId()).get();
    var data = snapshot.data() as Map<String, dynamic>;
    var name = data['primeiro_nome'];
    return name;
  }
  Future<String> get_segundo_nome() async{
    DocumentSnapshot snapshot = await userData.doc(await getUserId()).get();
    var data = snapshot.data() as Map<String, dynamic>;
    var name = data['segundo_nome'];
    return name;
  }

}

