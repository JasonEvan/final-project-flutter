import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _collectionReferenceUsers = FirebaseFirestore.instance.collection('users');
  final CollectionReference _collectionReferenceProducts = FirebaseFirestore.instance.collection('products');

  Future<User?> signUp(String nama, String telp, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception("User is null");
      }

      String? uid = userCredential.user?.uid;
      DocumentReference userRef = _collectionReferenceUsers.doc(uid);
      final userData = <String, dynamic> {
        "nama": nama,
        "telp": telp,
        "email": email,
        "pass": password
      };
      await userRef.set(userData);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception("User is null");
      }
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(String id, String nama, String deskripsi, String harga, String kategori) async {
    try {
      int hargaBaru = int.parse(harga);
      final format = NumberFormat.currency(
        locale: 'id_ID',
        symbol: "Rp. ",
        decimalDigits: 0
      ).format(hargaBaru);
      DocumentReference productRefs = _collectionReferenceProducts.doc(id);
      final data = <String, dynamic> {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "harga": format,
        "kategori": kategori
      };
      await productRefs.set(data);
    } catch(e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _collectionReferenceProducts.doc(id).delete();
    } catch(e) {
      rethrow;
    }
  }

  Future<void> submitEditProduct(String id, String nama, String desk, String harga, String kategori) async {
    await _collectionReferenceProducts.doc(id).update({
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': desk
    });
  }
}