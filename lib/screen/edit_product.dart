import 'package:flutter/material.dart';
import 'package:final_project/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:final_project/providers/editproduk_provider.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {

  bool _isLoading = false;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _deskController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final _editKey = GlobalKey<FormState>(); 
  final FirebaseService _auth = FirebaseService();

  Future<void> editProduct(BuildContext context) async {
    if (_editKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.submitEditProduct(
          _idController.text,
          _namaController.text,
          _deskController.text,
          _hargaController.text,
          _kategoriController.text);
        
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product berhasil diedit"))
        );
      } catch(e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An error occured"))
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff352d40),
      appBar: AppBar(
        backgroundColor: const Color(0xffcec2db),
        title: const Text("Edit Product", style: TextStyle(
          color: Color(0xff3a255b),
          fontSize: 20.0,
          fontWeight: FontWeight.w400
        ),),
      ),
      body: Consumer<EditProduk>(
        builder: (context, value, child) {

          _idController.text = value.produk["id"];
          _namaController.text = value.produk["nama"];
          _deskController.text = value.produk["deskripsi"];
          _hargaController.text = value.produk["harga"];
          _kategoriController.text = value.produk["kategori"];

          return SingleChildScrollView(
            child: Center(
              child: Form(
                key: _editKey,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget> [
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: _idController,
                        decoration: const InputDecoration(
                          labelText: "ID",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Minimum 5 character (Ex: tas123)",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.inventory_outlined),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "ID cannot empty";
                          }
                  
                          if (value.length < 5) {
                            return "Minimum 5 character";
                          }
                  
                          return null;
                        },
                        readOnly: true,
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama Produk",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Masukkan nama produk",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.shopping_bag_rounded),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama produk cannot empty";
                          }
                  
                          return null;
                        },
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        controller: _deskController,
                        decoration: const InputDecoration(
                          labelText: "Deskripsi Produk",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Minimum 10 character",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.description),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Description produk cannot empty";
                          }
                  
                          return null;
                        },
                      ),
                      const SizedBox(height: 15,),
                      TextFormField(
                        controller: _hargaController,
                        decoration: const InputDecoration(
                          labelText: "Harga Produk",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Ex: Rp. 10000",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.price_change),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Harga produk cannot empty";
                          }
          
                          if (value[0] != 'R' && value[1] != 'p' && value[2] != '.' && value[3] != ' ') {
                            return "Harga harus dalam rupiah";
                          }
                  
                          return null;
                        }
                      ),
                      const SizedBox(height: 15,),
                    TextFormField(
                      controller: _kategoriController,
                      decoration: const InputDecoration(
                        labelText: "Kategori Produk",
                        labelStyle: TextStyle(color: Color(0xffeadef7)),
                        helperText: "Masukkan kategori produk",
                        helperStyle: TextStyle(color: Color(0xffeadef7)),
                        prefixIcon: Icon(Icons.category),
                        prefixIconColor: Color(0xff968DA0),
                        filled: true,
                        fillColor: Color(0xff4b4357),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Kategori produk cannot empty";
                        }
          
                        return null;
                      },
                    ),
                    const SizedBox(
                        height: 25.0,
                      ),
                      _isLoading ? const CircularProgressIndicator() : ElevatedButton(
                        onPressed: () {
                          // benerin ini jdi edit product
                          editProduct(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(const Color(0xff513c73))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: const Text(
                            "Edit Produk",
                            style: TextStyle(color: Color(0xffecdcff)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}