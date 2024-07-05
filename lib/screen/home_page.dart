import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/firebase_service.dart';
import 'package:final_project/providers/editproduk_provider.dart';
import 'package:final_project/providers/profile_provider.dart';
import 'package:final_project/screen/add_product.dart';
import 'package:final_project/screen/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseService _auth = FirebaseService();
  final CollectionReference _productReference = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff352d40),
      appBar: AppBar(
        backgroundColor: const Color(0xffcec2db),
        title: const Text("BuyEase", style: TextStyle(
          color: Color(0xff3a255b),
          fontSize: 20.0,
          fontWeight: FontWeight.w400
        ),),
        actions: <Widget> [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
          const SizedBox(width: 15,),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          const SizedBox(width: 15,),
          IconButton(onPressed: () {
            dialog(context);
          }, 
          icon: const Icon(Icons.person_off_outlined)),
        ],
        actionsIconTheme: const IconThemeData(
          color: Color(0xff3a255b)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
          stream: _productReference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}', style: const TextStyle(
                  color: Color(0xffecdcff)
                ),),
              );
            }

            final docs = snapshot.data?.docs;
            if (docs == null || docs.isEmpty) {
              return const Center(
                child: Text("No data available", style: TextStyle(
                  color: Color(0xffecdcff)
                ),),
              );
            }

            List<Map<String, dynamic>> listData = docs.map((doc) {
              return doc.data() as Map<String, dynamic>;
            }).toList();

            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  color: const Color(0xff513c73),
                  child: ListTile(
                    onTap: () {
                      Provider.of<EditProduk>(context, listen: false).setEditProduk(
                        listData[index]['id'], 
                        listData[index]['nama'], 
                        listData[index]['deskripsi'], 
                        listData[index]['harga'], 
                        listData[index]['kategori']);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailProduct()));
                    },
                    title: Text(listData[index]['nama'], style: const TextStyle(color: Color(0xffecdcff)),),
                    subtitle: Text(listData[index]['harga'], style: const TextStyle(color: Color(0xffecdcff)),),
                  ),
                );
              },
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()));
        },
        backgroundColor: const Color(0xff513c73),
        shape: const CircleBorder(
          side: BorderSide(
            color: Color(0xffcec2db)
          )
        ),
        child: const Icon(Icons.add, color: Color(0xffcec2db),),
      ),
    );
  }

  void dialog(BuildContext context) {
    showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure you want to logout?'),
        content: SingleChildScrollView(
          child: Consumer<Profile>(
            builder: (context, value, child) {
              return Text("Current Email: ${value.email}");
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: const Text("Cancel")
          ),
          TextButton(
            onPressed: () async {
              await _auth.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }, 
            child: const Text("Logout")
          )
        ],
      );
    });
  }
}