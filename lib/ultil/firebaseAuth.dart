import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceCadasto {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> getUserCurrentID() async {
    return await firebaseAuth.currentUser!.uid;
  }

  Future<User?> registerUser(String email, String password,String primeiroNome, String segundoNome) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      String? userId = await getUserCurrentID();
      if (userId != null) {
        DocumentSnapshot documentSnapshot =
            await firestore.collection('user').doc(userId).get();
        if (!documentSnapshot.exists) {
          await firestore.collection('user').doc(userId).set({
            'email': email,
            'userId': userId,
            'primeiro_nome': primeiroNome,
            'segundo_nome': segundoNome,
            'mentor': "false",
            // Add any other user data you want to store
          });
          
        } else {
          print('User already exists!');
        }
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red));
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Nenhum usuario encontrado com esse email.');
      } else if (e.code == 'senha incorreta') {
        print('Senha incorreta do usuario.');
      }
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> getUserId() async {
    final User? user = await auth.currentUser;
    final userId = user?.uid.toString();
    return userId;
  }

  Future<String?> getUserEmail() async {
    final user = await auth.currentUser?.email;
    return user;
  }
 

}
