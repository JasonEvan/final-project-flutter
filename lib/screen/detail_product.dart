import "package:final_project/firebase_service.dart";
import "package:final_project/providers/editproduk_provider.dart";
import "package:final_project/screen/edit_product.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final FirebaseService _auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff352d40),
      appBar: AppBar(
        title: const Text(
          "Detail Product",
          style: TextStyle(
              color: Color(0xff3a255b),
              fontSize: 20.0,
              fontWeight: FontWeight.w400),
        ),
        actions: [
          Consumer<EditProduk> (
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  String id = value.produk['id'];
                  _dialog(context, id);
                }, 
                icon: const Icon(Icons.delete)
              );
            }
          )
        ],
        actionsIconTheme: const IconThemeData(color: Color(0xff3a255b)),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<EditProduk>(
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  const SizedBox(height: 20.0,),
                  Text("ID Produk: ${value.produk['id']}", style: const TextStyle(color: Color(0xffcec2db)),),
                  const SizedBox(height: 15,),
                  Text("Nama Produk: ${value.produk['nama']}", style: const TextStyle(color: Color(0xffcec2db)),),
                  const SizedBox(height: 15,),
                  Text("Deskripsi Produk: ${value.produk['deskripsi']}", style: const TextStyle(color: Color(0xffcec2db)),),
                  const SizedBox(height: 15,),
                  Text("Harga Produk: ${value.produk['harga']}", style: const TextStyle(color: Color(0xffcec2db)),),
                  const SizedBox(height: 15,),
                  Text("Kategori Produk: ${value.produk['kategori']}", style: const TextStyle(color: Color(0xffcec2db)),),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EditProductPage()));
        },
        backgroundColor: const Color(0xff513c73),
        shape: const CircleBorder(
          side: BorderSide(
            color: Color(0xffcec2db)
          )
        ),
        child: const Icon(Icons.edit_outlined, color: Color(0xffcec2db)),
      ),
    );
  }

  void _dialog(BuildContext context, String id) {
    showDialog(
      context: context, 
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Delete this item?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: const Text("Cancel")
                ),
                TextButton(
                  onPressed: () async {
                    await _auth.deleteProduct(id);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }, 
                  child: const Text("Delete")
                )
              ],
            );
          }
        );
      }
    );
  }
}
