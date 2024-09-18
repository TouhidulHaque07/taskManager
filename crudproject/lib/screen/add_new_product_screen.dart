
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class addNewProductScreen extends StatefulWidget {
  const addNewProductScreen({super.key});

  @override
  State<addNewProductScreen> createState() => _addNewProductScreenState();
}

class _addNewProductScreenState extends State<addNewProductScreen> {

  final TextEditingController _ProductNameTEController=TextEditingController();
  final TextEditingController _UnitPriceTEController=TextEditingController();
  final TextEditingController _TotalPriceTEController=TextEditingController();
  final TextEditingController _ImageTEController=TextEditingController();
  final TextEditingController _ProductCodeTEController=TextEditingController();
  final TextEditingController _QueantityTEController=TextEditingController();

  final GlobalKey<FormState> _fromKey=GlobalKey<FormState>();

  bool _isProgrss=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body:

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          _buildNewProductForm(),
        ),
      ),
    );
  }

  Widget _buildNewProductForm() {
    return Form(
        key: _fromKey,
        child: Column(
          children: [
            TextFormField(
              controller: _ProductNameTEController,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Product Name'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                   return 'Enter a Valid Name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _UnitPriceTEController,
              decoration: InputDecoration(
                  hintText: 'Unit Price',
                  labelText: 'Unit Price'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                  return 'Enter Price';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _TotalPriceTEController,
              decoration: InputDecoration(
                  hintText: 'Total Price',
                  labelText: 'Total Price'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                  return 'Enter Total Price';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ImageTEController,
              decoration: InputDecoration(
                  hintText: 'Image',
                  labelText: 'Image'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                  return 'Enter Image';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ProductCodeTEController,
              decoration: InputDecoration(
                  hintText: 'Product Code',
                  labelText: 'Product Code'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                  return 'Enter Product Code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _QueantityTEController,
              decoration: InputDecoration(
                  hintText: 'Quentity',
                  labelText: 'Quentity'
              ),
              validator: (String? value){
                if(value==null || value!.isEmpty){
                  return 'Enter Quentity';
                }
                return null;
              },
            ),

            SizedBox(height: 20),
            _isProgrss ? const Center(child: CircularProgressIndicator(),) : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(double.maxFinite),
                ),
                onPressed: _onTapAddProductButton,
                child: Text('Add Product')),
          ],
        ),
      );
  }

  void _onTapAddProductButton(){

    if(_fromKey.currentState!.validate()){
        addNewProiduct();
        setState(() {

        });
    }

  }

  Future<void> addNewProiduct() async{
    _isProgrss = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');

    Map<String, dynamic> jsonBody={
      "Img":_ImageTEController.text,
      "ProductCode":_ProductCodeTEController.text,
      "ProductName":_ProductNameTEController.text,
      "Qty":_QueantityTEController.text,
      "TotalPrice":_TotalPriceTEController.text,
      "UnitPrice":_UnitPriceTEController.text
    };

    Response response = await post(uri,
        headers: {
          "Content-Type":"application/json",
        },

        body: jsonEncode(jsonBody));

    if(response.statusCode==200){
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Product Add')));
    }
    _isProgrss=false;
    setState(() {
      
    });


  }
 void _clearTextField(){
   _ProductCodeTEController.clear();
   _UnitPriceTEController.clear();
   _TotalPriceTEController.clear();
   _ImageTEController.clear();
   _ProductNameTEController.clear();
   _QueantityTEController.clear();

 }

  @override
  void dispose() {
    _ProductCodeTEController.dispose();
    _UnitPriceTEController.dispose();
    _TotalPriceTEController.dispose();
    _ImageTEController.dispose();
    _ProductNameTEController.dispose();
    _QueantityTEController.dispose();
    super.dispose();

  }
}
